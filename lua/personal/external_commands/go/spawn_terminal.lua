---@module spawn_terminal
---@author tigor.hutasuhut@gmail.com
---@license MIT

---spawns terminal for testing
---@param cmdTable string[]
---@param test_name string
return function(cmdTable, test_name)
	local cmd = table.concat(cmdTable, ' ')
	local Term = require('toggleterm.terminal').Terminal

	local term = Term:new({
		cmd = cmd,
		direction = 'vertical',
		close_on_exit = false,
		on_open = function(t)
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
			vim.cmd([[call feedkeys("\<c-\>\<c-n>")]])
			if exit_code == 0 then
				vim.notify(cmd, nil, {
					timeout = 1000,
					title = 'Test ' .. test_name .. ' Passed',
				})
			else
				vim.notify(cmd, 'error', {
					timeout = 1000,
					title = 'Test ' .. test_name .. ' Failed',
				})
			end
		end,
	})

	term:toggle()
end
