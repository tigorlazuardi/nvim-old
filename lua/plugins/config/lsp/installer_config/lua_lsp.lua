local capabilities = require('plugins.config.lsp.capabilities')
local on_attach = require('plugins.config.lsp.on_attach')

local opts = {
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		client.resolved_capabilities.document_formatting = false
		vim.cmd([[command! DebugNeovim lua require('osv').run_this()]])
	end,
	settings = {
		Lua = {
			diagnostics = {
				enable = false,
			},
		},
	},
}

return opts
