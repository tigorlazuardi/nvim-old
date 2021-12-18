return function(use)
	use({
		'folke/tokyonight.nvim',
		setup = function()
			vim.g.tokyonight_style = 'storm'
			vim.g.tokyonight_sidebars = { 'qf', 'vista_kind', 'terminal', 'packer', 'NvimTree' }
			vim.g.tokyonight_italic_functions = true
			-- vim.g.tokyonight_transparent = require('config.firenvim').run()
		end,
		config = function()
			-- vim.cmd([[colorscheme tokyonight]])
		end,
	})

	use({
		'EdenEast/nightfox.nvim',
		event = 'VimEnter',
		config = function()
			local nightfox = require('nightfox')
			nightfox.setup({
				styles = {
					keywords = 'bold',
					functions = 'italic,bold',
				},
			})
			-- nightfox.load()
		end,
	})
	use({
		'sainnhe/edge',
		event = 'VimEnter',
		setup = function()
			vim.g.edge_style = 'aura'
			vim.g.edge_enable_italic = 1
			vim.g.edge_disable_italic_comment = 0
		end,
	})
	-- use({
	-- 	'projekt0n/github-nvim-theme',
	-- 	config = function()
	-- 		-- require('github-theme').setup({
	-- 		-- 	theme_style = 'dimmed',
	-- 		-- 	comment_style = 'italic',
	-- 		-- 	keyword_style = 'italic',
	-- 		-- 	function_style = 'italic',
	-- 		-- 	variable_style = 'italic',
	-- 		-- })
	-- 	end,
	-- })

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
		'tssm/nvim-random-colors',
		event = 'VimEnter',
		setup = function()
			local load = require('packer').loader
			-- load('github-nvim-theme')
			load('everforest')
			load('edge')
			load('nightfox.nvim')
			load('tokyonight.nvim')
			load('nord.nvim')
		end,
		config = function()
			vim.cmd([[command! RandomColors lua require('random-colors')()]])
		end,
	})
end
