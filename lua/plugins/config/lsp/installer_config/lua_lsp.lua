local capabilities = require('plugins.config.lsp.capabilities')
local on_attach = require('plugins.config.lsp.on_attach')

local opts = {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				enable = false,
			},
		},
	},
}

return require('lua-dev').setup({
	library = { vimruntime = true, types = true, plugins = true },
	lspconfig = opts,
})
