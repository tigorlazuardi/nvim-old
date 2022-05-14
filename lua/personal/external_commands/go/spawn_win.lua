---@module spawn_terminal
---@author tigor.hutasuhut@gmail.com
---@license MIT

---spawns window to get test output
---@param cmdTable string[]
---@param test_name string
return function(cmdTable, test_name)
	-- local current_buf = vim.api.nvim_get_current_buf()
	local current_buf_height = vim.fn.winheight(0)

	local max_height = math.floor(current_buf_height * 2 / 3)

	local Popup = require('nui.popup')
	local event = require('nui.utils.autocmd').event
	local cmd = table.concat(cmdTable, ' ')
	local biggest_line_length = cmd:len()

	local popup = Popup({
		enter = true,
		focusable = true,
		relative = 'editor',
		size = {
			width = biggest_line_length,
			height = '33%',
		},
		position = {
			row = '33%',
			col = '50%',
		},
		buf_options = {
			modifiable = true,
			readonly = false,
		},
		zindex = 50,
		border = {
			padding = {
				top = 2,
				bottom = 2,
				left = 3,
				right = 3,
			},
			style = 'rounded',
			text = {
				top = test_name,
				top_align = 'center',
				bottom = cmd,
				bottom_align = 'left',
			},
		},
	})

	popup:mount()
	popup:on(event.BufHidden, function()
		vim.schedule(function()
			popup:unmount()
		end)
	end)

	local buf_out = io.popen(cmd)

	local i = 0
	for line in buf_out:lines() do
		local len = line:len()
		if len > biggest_line_length then
			biggest_line_length = len
		else
			len = biggest_line_length
		end
		local height = i + 3
		if height > max_height then
			height = max_height
		end
		popup:set_size({ width = len, height = height })
		vim.api.nvim_buf_set_lines(popup.bufnr, i, i, false, { line })
		i = i + 1
	end

	buf_out:close()

	vim.api.nvim_buf_set_option(popup.bufnr, 'readonly', true)
	vim.api.nvim_buf_set_option(popup.bufnr, 'modifiable', false)

	local close = function(key)
		return {
			'n',
			key,
			function(_bufnr)
				vim.schedule(function()
					popup:unmount()
				end)
			end,
			{ noremap = true },
		}
	end
	popup:map(unpack(close('<esc>')))
	popup:map(unpack(close('q')))
	popup:map(unpack(close('<c-c>')))
	popup:map(unpack(close('<c-[>')))
end
