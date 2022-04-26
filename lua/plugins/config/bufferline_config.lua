return function(use)
	use({
		'akinsho/nvim-bufferline.lua',
		requires = 'kyazdani42/nvim-web-devicons',
		after = { 'which-key.nvim' },
		setup = function()
			vim.opt.termguicolors = true
		end,
		config = function()
			require('bufferline').setup({
				options = {
					numbers = 'buffer_id',
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
					separator_style = 'thin',
					diagnostics_indicator = function(_count, _level, diagnostics_dict, _context)
						local s = ' '
						for e, n in pairs(diagnostics_dict) do
							local sym = e == 'error' and ' ' or (e == 'warning' and ' ' or '')
							s = s .. n .. sym
						end
						return s
					end,
					-- TODO: Enable later after it has been fixed
					-- groups = {
					-- 	options = {
					-- 		toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
					-- 	},
					-- 	items = {
					-- 		{
					-- 			name = 'Tests', -- Mandatory
					-- 			highlight = { gui = 'underline', guisp = 'blue' }, -- Optional
					-- 			priority = 2, -- determines where it will appear relative to other groups (Optional)
					-- 			icon = '', -- Optional
					-- 			matcher = function(buf) -- Mandatory
					-- 				return buf.name:match('%_test') or buf.name:match('%_spec')
					-- 			end,
					-- 		},
					-- 		{
					-- 			name = 'Docs',
					-- 			highlight = { gui = 'undercurl', guisp = 'green' },
					-- 			auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
					-- 			matcher = function(buf)
					-- 				return buf.name:match('%.md') or buf.name:match('%.txt')
					-- 			end,
					-- 			separator = { -- Optional
					-- 				style = require('bufferline.groups').separator.tab,
					-- 			},
					-- 		},
					-- 	},
					-- },
				},
			})
			require('which-key').register({
				['[t'] = { '<cmd>BufferLineCyclePrev<cr>', 'Previous Buffer' },
				[']t'] = { '<cmd>BufferLineCycleNext<cr>', 'Next Buffer' },
			})
		end,
	})
end
