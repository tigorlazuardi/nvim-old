return function(use)
	use({
		'nvim-lualine/lualine.nvim',
		requires = {
			'kyazdani42/nvim-web-devicons',
		},
		config = function()
			vim.cmd([[set cmdheight=1]])
			vim.cmd([[set noshowmode]])
			local opts = require('plugins.config.lualine_config.slanted_gaps')
			require('lualine').setup(opts)
		end,
	})
end
