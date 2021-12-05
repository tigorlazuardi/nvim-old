return function(use)
	use({
		'windwp/windline.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', 'nvim-lua/lsp-status.nvim' },
		config = function()
			vim.cmd('PackerLoad lsp-status.nvim')
			local lsp_status = require('lsp-status')
			lsp_status.config({
				indicator_errors = '',
				indicator_warnings = '',
				indicator_info = '',
				indicator_hint = '',
				indicator_ok = '',
			})
			lsp_status.register_progress()
			vim.cmd([[set cmdheight=1]])
			vim.cmd([[set noshowmode]])
			require('plugins.config.windline_config.airline')
		end,
		event = 'BufEnter',
	})
end
