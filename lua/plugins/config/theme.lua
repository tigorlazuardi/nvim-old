local function tokyonight_setup()
	vim.g.tokyonight_style = 'storm'
	vim.g.tokyonight_sidebars = { 'qf', 'vista_kind', 'terminal', 'packer', 'NvimTree' }
	vim.g.tokyonight_italic_functions = true
	-- vim.g.tokyonight_transparent = require('config.firenvim').run()

	vim.g.nord_underline_option = 'underline'
	vim.g.nord_italic = true
	vim.g.nord_italic_comments = false
	vim.g.nord_minimal_mode = false

	vim.g.edge_style = 'aura'
	vim.g.edge_enable_italic = 1
	vim.g.edge_disable_italic_comment = 0
end

return function(use)
	use({
		'folke/tokyonight.nvim',
		disable = vim.g.vscode,
		setup = tokyonight_setup,
		config = function()
			vim.cmd([[colorscheme tokyonight]])
		end,
	})

	use({
		'EdenEast/nightfox.nvim',
		disable = vim.g.vscode,
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
	use('sainnhe/edge')
	use({
		'projekt0n/github-nvim-theme',
		config = function()
			-- require('github-theme').setup({
			-- 	theme_style = 'dimmed',
			-- 	comment_style = 'italic',
			-- 	keyword_style = 'italic',
			-- 	function_style = 'italic',
			-- 	variable_style = 'italic',
			-- })
		end,
	})

	use({
		'sainnhe/everforest',
		config = function()
			-- vim.cmd([[colorscheme everforest]])
		end,
	})
end
