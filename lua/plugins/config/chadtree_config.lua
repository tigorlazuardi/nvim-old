return function(use)
	use({
		'ms-jpq/chadtree',
		branch = 'chad',
		run = { 'python3 -m chadtree deps', ':CHADdeps' },
		requires = { 'ryanoasis/vim-devicons', 'adelarsq/vim-emoji-icon-theme' },
		setup = function()
			vim.g.chadtree_settings = {
				view = {
					width = 30,
				},
			}
		end,
		config = function()
			require('which-key').register({
				['<leader>e'] = { '<cmd>CHADopen<cr>', 'Open Tree' },
			})
		end,
	})
end
