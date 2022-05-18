return function(use)
	use({
		'ThePrimeagen/harpoon',
		requires = { 'nvim-lua/plenary.nvim' },
		config = function()
			local ok, telescope = pcall(require, 'telescope')
			if not ok then
				telescope.load_extension('harpoon')
			end

			require('which-key').register({
				gm = { [[<cmd>lua require('harpoon.mark').add_file()<cr>]], 'Mark File' },
				gf = { [[<cmd>Telescope harpoon marks<cr>]], 'Show Marks' },
			})
		end,
	})
end
