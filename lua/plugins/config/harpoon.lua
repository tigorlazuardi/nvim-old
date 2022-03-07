return function(use)
	use({
		'ThePrimeagen/harpoon',
		requires = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('telescope').load_extension('harpoon')
			require('which-key').register({
				gm = { [[<cmd>lua require('harpoon.mark').add_file()<cr>]], 'Mark File' },
				gf = { [[<cmd>Telescope harpoon marks<cr>]], 'Show Marks' },
			})
		end,
	})
end
