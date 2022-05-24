return function(use)
	use({
		'SmiteshP/nvim-gps',
		requires = 'nvim-treesitter/nvim-treesitter',
		config = function()
			local gps = require('nvim-gps')
			gps.setup({
				icons = {
					['class-name'] = ' ', -- Classes and class-like objects
					['function-name'] = ' ', -- Functions
					['method-name'] = ' ', -- Methods (functions inside class-like objects)
					['container-name'] = '⛶ ', -- Containers (example: lua tables)
					['tag-name'] = '炙', -- Tags (example: html tags)
				},
			})
			local augroup = vim.api.nvim_create_augroup('gps_move', {})
			vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'BufEnter' }, {
				pattern = { '*' },
				group = augroup,
				callback = function()
					if gps.is_available() then
						local g = gps.get_location()
						if g ~= '' then
							vim.api.nvim_win_set_option(0, 'winbar', '%m %f | ' .. g)
						else
							vim.api.nvim_win_set_option(0, 'winbar', '%m %f')
						end
					else
						vim.api.nvim_win_set_option(0, 'winbar', '')
					end
				end,
				desc = 'Update Nvim GPS on move',
			})
		end,
	})
end
