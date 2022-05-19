local capabilities = require('plugins.config.lsp.capabilities')
local on_attach = require('plugins.config.lsp.on_attach')
local opts = {
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = true
		on_attach(client, bufnr)
		vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
			callback = function()
				require('go.format').goimport()
			end,
			buffer = bufnr,
		})
		local wk = require('which-key')

		wk.register({
			['<leader>g'] = {
				name = '+go',
				f = { '<cmd>GoImport<cr>', 'Organize Imports' },
				d = {
					name = '+debug',
					f = {
						function()
							require('personal.external_commands.go.test_current_func').debug()
						end,
						'Debug Current Function',
					},
				},
				t = {
					name = '+test',
					f = {
						function()
							require('personal.external_commands.go.test_current_func').run()
						end,
						'Test Current Function',
					},
					F = { '<cmd>GoTestFile<cr>', 'Test Current File' },
					p = {
						function()
							require('personal.external_commands.go.test_current_package').run()
						end,
						'Test Current Package',
					},
					t = {
						function()
							require('personal.external_commands.go.test_current_workspace').run()
						end,
						'Test All in Project',
					},
					c = {
						function()
							require('nvim-goc').ClearCoverage()
						end,
						'Clear Coverage',
					},
					r = {
						function()
							require('nvim-goc').Coverage()
						end,
						'Coverage',
					},
					R = {
						function()
							require('nvim-goc').CoverageFunc()
						end,
						'Coverage Func',
					},
					a = { '<cmd>GoAddTest<cr>', 'Generate test for function' },
					A = { '<cmd>GoAddAllTest<cr>', 'Generate test for functions in file' },
				},
				a = { '<cmd>GoAddTag<cr>', 'Generate Tag for Struct' },
				c = { '<cmd>GoCmt<cr>', 'Generate comment for function or struct' },
			},
		}, { buffer = bufnr })
	end,
	settings = {
		gopls = {
			-- more settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
			analyses = { unusedparams = true, unreachable = false },
			codelenses = {
				generate = true, -- show the `go generate` lens.
				gc_details = true, -- Show a code lens toggling the display of gc's choices.
			},
			usePlaceholders = false,
			completeUnimported = true,
			staticcheck = false, -- in favor of golangci lint
			matcher = 'Fuzzy',
			diagnosticsDelay = '500ms',
			symbolMatcher = 'FastFuzzy',
			gofumpt = false, -- depending on your projects, you may want this on.
		},
	},
}

require('lspconfig').gopls.setup(opts)
require('lspconfig').golangci_lint_ls.setup({})
