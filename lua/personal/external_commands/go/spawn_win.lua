---@module spawn_terminal
---@author tigor.hutasuhut@gmail.com
---@license MIT

---spawns window to get test output
---@param cmdTable string[]
---@param test_name string
return function(cmdTable, _test_name)
	local Split = require('nui.split')

	local split = Split({
		relative = 'editor',
		position = 'right',
		size = '50%',
		buf_options = {
			modifiable = true,
			readonly = false,
		},
	})

	split:mount()

	local buf_out = io.popen(table.concat(cmdTable, ' '))

	local i = 0
	for line in buf_out:lines() do
		vim.api.nvim_buf_set_lines(split.bufnr, i, i, false, { line })
		i = i + 1
	end

	buf_out:close()

	vim.api.nvim_buf_set_option(split.bufnr, 'readonly', true)
	vim.api.nvim_buf_set_option(split.bufnr, 'modifiable', false)

	local close = function(key)
		return {
			'n',
			key,
			function(_bufnr)
				vim.schedule(function()
					split:unmount()
				end)
			end,
			{ noremap = true },
		}
	end
	split:map(unpack(close('<esc>')))
	split:map(unpack(close('q')))
	split:map(unpack(close('<c-c>')))
	split:map(unpack(close('<c-[>')))
end
