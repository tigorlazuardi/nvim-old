return function(use)
	require('plugins.config.lsp.rust')(use)
	use({
		'neovim/nvim-lspconfig',
		requires = {
			'ray-x/lsp_signature.nvim',
			'folke/lua-dev.nvim',
			'folke/lsp-colors.nvim',
			'nvim-lua/lsp_extensions.nvim',
			'b0o/schemastore.nvim',
			'kosayoda/nvim-lightbulb',
			-- 'tami5/lspsaga.nvim',
			{ 'jose-elias-alvarez/nvim-lsp-ts-utils', wants = { 'null-ls.nvim' } },
		},
		-- after = { 'telescope.nvim', 'which-key.nvim' },
		setup = function()
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
		end,
		config = function()
			local wk = require('which-key')

			wk.register({
				['<leader>l'] = {
					name = '+lsp',
					i = { '<cmd>LspInfo<cr>', 'LSP Info' },
					r = { '<cmd>LspRestart<cr>', 'LSP Restart' },
					S = {
						function()
							for _, client in pairs(vim.lsp.buf_get_clients()) do
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
			vim.cmd([[autocmd CursorHold,CursorHoldI * silent! lua require'nvim-lightbulb'.update_lightbulb()]])

			-- require('lspsaga').init_lsp_saga()
			require('plugins.config.lsp.setup')
		end,
	})
end
