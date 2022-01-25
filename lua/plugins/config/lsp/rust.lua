return function(use)
	use({
		'simrat39/rust-tools.nvim',
		wants = { 'nvim-lspconfig', 'which-key.nvim' },
		config = function()
			require('plugins.config.lsp.installer_config.rust')
		end,
		ft = { 'rust' },
	})
end
