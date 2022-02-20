local M = {}
local utils = require('go.utils')
local empty = utils.empty

local get_build_tags = require('personal.external_commands.go.get_build_tags')

---returns generated cmd table of string.
---@vararg string string to generated the rest of cmd
---@return strings table returns a list table of string. Nil if failed to find top function name via treesitter. e.g. cursor not inside a function.
function M.get_cmd(...)
	local args = { ... }
	local fpath = vim.fn.expand('%:p:h')
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	row, col = row, col + 1
	local ns = require('go.ts.go').get_func_method_node_at_pos(row, col)
	if empty(ns) then
		return
	end

	local tags, args2 = get_build_tags(args)
	local cmd = { 'go', 'test', '-v' }
	if not empty(tags) then
		cmd = vim.list_extend(cmd, tags)
	end
	if not empty(args2) then
		cmd = vim.list_extend(cmd, args2)
	end

	if ns.name:find('Bench') then
		local bench = '-bench=' .. ns.name
		table.insert(cmd, bench)
	end

	table.insert(cmd, '-run')
	table.insert(cmd, [[^]] .. ns.name)

	table.insert(cmd, fpath)
	return cmd
end

---Runs test in a new toggleterm terminal.
---@vararg string extra args to pass to go test function
function M.run(...)
	local cmdTable = M.get_cmd(...)
	if cmdTable == nil then
		return
	end
	local cmd = table.concat(cmdTable, ' ')
	local Term = require('toggleterm.terminal').Terminal

	local gotest_out = Term:new({
		cmd = cmd,
		direction = 'vertical',
		close_on_exit = false,
		on_open = function(t)
			vim.cmd([[call feedkeys("\<c-\>\<c-n>")]])
			local close = function()
				t:close()
			end
			local modes = { 't', 'n' }
			local opts = { buffer = t.bufnr }
			vim.keymap.set(modes, 'q', close, opts)
			vim.keymap.set(modes, '<esc>', close, opts)
			vim.keymap.set(modes, '<c-[>', close, opts)
		end,
		on_exit = function(_term, _job, exit_code)
			local test_name = ''
			for _, str in ipairs(cmdTable) do
				if str:find('%^Test') then
					test_name = str:sub(2)
					break
				end
			end
			if exit_code == 0 then
				vim.notify(cmd, nil, {
					timeout = 1000,
					title = test_name .. ' Passed',
				})
			else
				vim.notify(cmd, 'error', {
					timeout = 1000,
					title = test_name .. ' Failed',
				})
			end
		end,
	})

	gotest_out:toggle()
end

return M
