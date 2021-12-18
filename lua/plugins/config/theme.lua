return function(use)
	use({
		'sainnhe/edge',
		event = 'VimEnter',
		setup = function()
			vim.g.edge_style = 'aura'
			vim.g.edge_enable_italic = 1
			vim.g.edge_disable_italic_comment = 0
		end,
	})
	use({
		'sainnhe/everforest',
		event = 'VimEnter',
	})

	use({
		'shaunsingh/nord.nvim',
		setup = function()
			vim.g.nord_underline_option = 'underline'
			vim.g.nord_italic = true
			vim.g.nord_italic_comments = false
			vim.g.nord_minimal_mode = false
		end,
	})

	use({
		'kvrohit/substrata.nvim',
	})

	use({
		'catppuccin/nvim',
		as = 'catppuccin',
	})

	use({
		'tssm/nvim-random-colors',
		event = 'VimEnter',
		setup = function()
			local load = require('packer').loader
			load('everforest')
			load('edge')
			load('nord.nvim')
			load('substrata.nvim')
			load('catppuccin')
		end,
		config = function()
			vim.cmd([[command! RandomColors lua require('random-colors')()]])
		end,
	})
end
