return function(use)
	if vim.fn.exepath('gopls') ~= '' then
		use({
			'ray-x/go.nvim',
			requires = { 'ray-x/guihua.lua' },
			config = function()
				local lsp_installer_servers = require('nvim-lsp-installer.servers')
				local _, gopls = lsp_installer_servers.get_server('gopls')
				gopls:on_ready(function()
					local on_attach = require('plugins.config.lsp.on_attach')
					local opts = {
						capabilities = require('plugins.config.lsp.capabilities'),
						on_attach = function(client, bufnr)
							client.resolved_capabilities.document_formatting = true
							on_attach(client, bufnr)
							vim.cmd([[autocmd BufWritePre <buffer> lua require("go.format").goimport()]])
							local wk = require('which-key')
							wk.register({
								['<leader>g'] = {
									name = '+go',
									f = {
										function()
											require('go.format').goimport()
										end,
										'Organize Imports',
									},
									i = {
										function()
											require('telescope').extensions.goimpl.goimpl()
										end,
										'Generate Implementations',
									},
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
								matcher = 'fuzzy',
								diagnosticsDelay = '500ms',
								symbolMatcher = 'fuzzy',
								gofumpt = false, -- depending on your projects, you may want this on.
							},
						},
					}
					gopls:setup(opts)
				end)

				if not gopls:is_installed() then
					gopls:install()
				end
				require('go').setup({
					gofmt = 'gofumpt',
					max_line_len = 120, -- max line length in goline format
					tag_transform = false, -- tag_transfer  check gomodifytags for details
					verbose = false, -- output loginf in messages
					lsp_cfg = false, -- true: apply go.nvim non-default gopls setup
					dap_debug = false, -- set to true to enable dap
				})
			end,
			ft = { 'go' },
		})
	end

	use({
		'rafaelsq/nvim-goc.lua',
		config = function()
			require('nvim-goc').setup({})

			require('which-key').register({
				['<leader>g'] = {
					name = '+go',
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
					t = {
						function()
							require('nvim-goc').CoverageFunc()
						end,
						'Coverage Func',
					},
				},
			})
		end,
		ft = { 'go' },
	})

	use({
		'edolphin-ydf/goimpl.nvim',
		config = function()
			local ok, telescope = pcall(require, 'telescope')
			if not ok then
				return
			end

			telescope.load_extension('goimpl')
		end,
		ft = { 'go' },
	})
end
