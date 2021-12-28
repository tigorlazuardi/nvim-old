if vim.fn.exepath('vscode-json-languageserver') ~= '' then
	require('lspconfig').jsonls.setup({
		cmd = { 'vscode-json-languageserver', '--stdio' },
		commands = {
			Format = {
				function()
					vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line('$'), 0 })
				end,
			},
		},
		settings = {
			json = {
				schemas = require('schemastore').json.schemas(),
			},
		},
		on_attach = function(client, bufnr)
			client.resolved_capabilities.document_formatting = false
			require('plugins.config.lsp.on_attach')(client, bufnr)
		end,
		capabilities = require('plugins.config.lsp.capabilities'),
	})
end
