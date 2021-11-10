return function(use)
	use({
		'windwp/windline.nvim',
		requires = { 'kyazdani42/nvim-web-devicons','nvim-lua/lsp-status.nvim'  },
		config = function()
			vim.cmd([[set cmdheight=1]])
			vim.cmd([[set noshowmode]])
			require('plugins.config.windline_config.airline')
		end,
	})
end
