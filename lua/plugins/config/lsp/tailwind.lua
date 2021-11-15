local capabilities = require "plugins.config.lsp.capabilities"
local on_attach    = require "plugins.config.lsp.on_attach"

if vim.fn.exepath('tailwindcss-language-server') ~= '' then
	local lspconfig = require('lspconfig')

	lspconfig.tailwindcss.setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})
end
