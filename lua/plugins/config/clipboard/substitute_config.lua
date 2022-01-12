return function(use)
	use({
		'gbprod/substitute.nvim',
		config = function()
			require('substitute').setup()

			require('which-key').register({
				['<leader>s'] = { [[<cmd>lua require('substitute').operator()<cr>]], 'Substitute' },
				['<leader>ss'] = { [[<cmd>lua require('substitute').line()<cr>]], 'Substitute Line' },
				['<leader>S'] = { [[<cmd>lua require('substitute').eol()<cr>]], 'Substitute End of Line' },
			})

			require('which-key').register({
				['<leader>s'] = { [[<cmd>lua require('substitute').visual()<cr>]], 'Substitute' },
			}, { mode = 'x' })
		end,
	})
end
