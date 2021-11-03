return function(use)
	use({
		'windwp/windline.nvim',
		requires = { 'kyazdani42/nvim-web-devicons' },
		config = function()
			vim.cmd([[set cmdheight=1]])
			vim.cmd([[set noshowmode]])
			require('wlsample.airline')
		end,
	})
end
