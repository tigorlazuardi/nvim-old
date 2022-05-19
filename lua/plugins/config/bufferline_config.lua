return function(use)
	use({
		'akinsho/nvim-bufferline.lua',
		requires = 'kyazdani42/nvim-web-devicons',
		after = { 'which-key.nvim' },
		setup = function()
			vim.opt.termguicolors = true
		end,
		config = function()
			local groups = require('bufferline.groups')
			require('bufferline').setup({
				options = {
					numbers = 'none',
					custom_filter = function(bufnr)
						if vim.bo[bufnr].filetype ~= 'dashboard' then
							return true
						end
						if vim.bo[bufnr].filetype ~= 'alpha' then
							return true
						end
						if vim.bo[bufnr].filetype ~= 'packer' then
							return true
						end
					end,
					diagnostics = 'nvim_lsp',
					diagnostics_indicator = function(_count, _level, diagnostics_dict, _context)
						local s = ' '
						for e, n in pairs(diagnostics_dict) do
							local sym = e == 'error' and ' ' or (e == 'warning' and ' ' or '')
							s = s .. n .. sym
						end
						return s
					end,
					groups = {
						options = {
							toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
						},
						items = {
							groups.builtin.ungrouped,
							{
								name = 'Tests', -- Mandatory
								auto_close = false,
								icon = '', -- Optional
								matcher = function(buf) -- Mandatory
									return buf.name:match('%_test') or buf.name:match('%_spec')
								end,
							},
							{
								name = 'Docs',
								auto_close = true, -- whether or not close this group if it doesn't contain the current buffer
								icon = '', -- Optional
								matcher = function(buf)
									return buf.name:match('%.md') or buf.name:match('%.txt')
								end,
							},
						},
					},
				},
			})
			vim.keymap.set('n', '[t', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Previous Buffer' })
			vim.keymap.set('n', ']t', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next Buffer' })
		end,
	})
end
