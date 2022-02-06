return function(use)
	use({
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', 'nvim-lua/lsp-status.nvim' },
		config = function()
			local lsp_status = require('lsp-status')
			lsp_status.config({
				indicator_errors = '',
				indicator_warnings = '',
				indicator_info = '',
				indicator_hint = '',
				indicator_ok = '',
				diagnostics = false,
				show_filename = false,
				status_symbol = ' ',
			})
			lsp_status.register_progress()
			vim.cmd([[set cmdheight=1]])
			vim.cmd([[set noshowmode]])
			local opts = require('plugins.config.lualine_config.slanted_gaps')
			require('lualine').setup(opts)
		end,
	})
end
