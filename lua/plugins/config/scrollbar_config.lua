return function(use)
	use({
		'petertriho/nvim-scrollbar',
		requires = { 'kevinhwang91/nvim-hlslens', 'folke/tokyonight.nvim' },
		config = function()
			vim.cmd([[
				noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
							\<Cmd>lua require('hlslens').start()<CR>
				noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
							\<Cmd>lua require('hlslens').start()<CR>
				noremap * *<Cmd>lua require('hlslens').start()<CR>
				noremap # #<Cmd>lua require('hlslens').start()<CR>
				noremap g* g*<Cmd>lua require('hlslens').start()<CR>
				noremap g# g#<Cmd>lua require('hlslens').start()<CR>

				" use : instead of <Cmd>
				nnoremap <silent> <leader>l :noh<CR>
			]])

			local colors = require('tokyonight.colors').setup()
			require('scrollbar').setup({
				handle = {
					color = colors.bg_highlight,
				},
				marks = {
					Search = { color = colors.orange },
					Error = { color = colors.error },
					Warn = { color = colors.warning },
					Info = { color = colors.info },
					Hint = { color = colors.hint },
					Misc = { color = colors.purple },
				},
			})
			require('scrollbar.handlers.search').setup()
		end,
	})
end
