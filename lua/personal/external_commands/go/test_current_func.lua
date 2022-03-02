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
	local cmd = { 'go', 'test', '-v', '-count=1' }
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
	table.insert(cmd, [[^]] .. ns.name .. [[$]])

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
	local test_name = ''
	for _, str in ipairs(cmdTable) do
		if str:find('%^Test') then
			test_name = str:sub(2)
			break
		end
	end
	require('personal.external_commands.go.spawn_terminal')(cmdTable, test_name)
end

return M
