return function(use)
	-- https://github.com/folke/trouble.nvim#%EF%B8%8F-configuration
	use({
		'folke/trouble.nvim',
		requires = 'kyazdani42/nvim-web-devicons',
		wants = { 'which-key.nvim' },
		event = 'BufEnter',
		config = function()
			require('trouble').setup({
				position = 'right',
			})
			local wk = require('which-key')
			wk.register({
				['<leader>x'] = {
					name = '+trouble',
					x = { '<cmd>TroubleToggle<cr>', 'Toggle Trouble' },
					w = {
						'<cmd>TroubleToggle lsp_workspace_diagnostics<cr>',
						'Toggle Trouble LSP Workspace Diagnostics',
					},
					d = {
						'<cmd>TroubleToggle lsp_document_diagnostics<cr>',
						'Toggle Trouble LSP Document Diagnostics',
					},
					l = { '<cmd>TroubleToggle loclist<cr>', 'Toggle Trouble loclist' },
					q = { '<cmd>TroubleToggle quickfix<cr>', 'Toggle Trouble quickfix' },
					r = { '<cmd>TroubleToggle lsp_references<cr>', 'Toggle Trouble LSP References' },
				},
			})
		end,
	})
end
