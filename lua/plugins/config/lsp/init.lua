return function(use)
	use({
		'neovim/nvim-lspconfig',
		requires = {
			'ray-x/lsp_signature.nvim',
			'folke/lua-dev.nvim',
			'folke/lsp-colors.nvim',
			'nvim-lua/lsp_extensions.nvim',
			'b0o/schemastore.nvim',
			'kosayoda/nvim-lightbulb',
			'williamboman/nvim-lsp-installer',
			'j-hui/fidget.nvim',
			'jose-elias-alvarez/nvim-lsp-ts-utils',
			'b0o/schemastore.nvim',
			'simrat39/rust-tools.nvim',
		},
		setup = function()
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				float = { border = 'single' },
			})

			local signs = { Error = ' ', Warn = ' ', Hint = ' ', Information = ' ' }

			for type, icon in pairs(signs) do
				local hl = 'DiagnosticSign' .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
			end

			vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = 'single',
			})

			vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = 'single',
			})

			vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
				vim.lsp.diagnostic.on_publish_diagnostics,
				{ update_in_insert = false }
			)
		end,
		config = function()
			require('nvim-lsp-installer').setup({
				automatic_installation = true,
			})
			local wk = require('which-key')

			wk.register({
				['<leader>l'] = {
					name = '+lsp',
					i = { '<cmd>LspInfo<cr>', 'LSP Info' },
					r = { '<cmd>LspRestart<cr>', 'LSP Restart' },
					S = {
						function()
							for _, client in pairs(vim.lsp.get_active_clients()) do
								client.stop()
							end
						end,
						'LSP Stop',
					},
					s = { '<cmd>LspStart<cr>', 'LSP Start' },
				},
			})

			require('lsp_extensions').inlay_hints({
				highlight = 'Comment',
				prefix = ' > ',
				aligned = false,
				only_current_line = false,
				enabled = { 'ChainingHint' },
			})
			require('fidget').setup({})
			vim.cmd([[autocmd CursorHold,CursorHoldI * silent! lua require'nvim-lightbulb'.update_lightbulb()]])
			-- vim.cmd([[au CursorHold * lua vim.diagnostic.open_float(0,{scope = "cursor", focus = false})]])
			-- require('plugins.config.lsp.setup')
			require('plugins.config.lsp.installer_config')
		end,
	})
end
