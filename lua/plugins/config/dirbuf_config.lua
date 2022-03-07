return function(use)
	use({
		'elihunter173/dirbuf.nvim',
		config = function()
			require('dirbuf').setup({})

			require('which-key').register({
				['<leader>E'] = { '<cmd>Dirbuf<cr>', 'Opens Dirbuf at Current Directory' },
			})
		end,
	})
end
