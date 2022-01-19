local capabilities = require('plugins.config.lsp.capabilities')
local on_attach = require('plugins.config.lsp.on_attach')

local opts = {
	capabilities = capabilities,
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
						_G.organize_imports(1000)
					end,
					'Organize Imports',
				},
			},
		}, { buffer = bufnr })

		if packer_plugins['goimpl.nvim'] then
			wk.register({
				['<leader>gi'] = {
					function()
						require('telescope').extensions.goimpl.goimpl()
					end,
					'Generate Implementations',
				},
			}, { buffer = bufnr })
		end
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

return opts
