return function(use)
	-- https://github.com/folke/trouble.nvim#%EF%B8%8F-configuration
	use({
		'folke/trouble.nvim',
		requires = 'kyazdani42/nvim-web-devicons',
		config = function()
			require('trouble').setup({
				-- position = 'right',
			})
			local wk = require('which-key')
			wk.register({
				['<leader>x'] = {
					name = '+trouble',
					x = {
						function()
							require('trouble').toggle()
						end,
						'Toggle Trouble',
					},
					w = {
						function()
							require('trouble').toggle('workspace_diagnostics')
						end,
						'Toggle Trouble LSP Workspace Diagnostics',
					},
					d = {
						function()
							require('trouble').toggle('document_diagnostics')
						end,
						'Toggle Trouble LSP Document Diagnostics',
					},
					l = {
						function()
							require('trouble').toggle('loclist')
						end,
						'Toggle Trouble loclist',
					},
					q = {
						function()
							require('trouble').toggle('quickfix')
						end,
						'Toggle Trouble quickfix',
					},
					r = {
						function()
							require('trouble').toggle('lsp_references')
						end,
						'Toggle Trouble LSP References',
					},
				},
			})
		end,
	})
end
