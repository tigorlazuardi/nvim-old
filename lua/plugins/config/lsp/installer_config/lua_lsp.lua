local capabilities = require('plugins.config.lsp.capabilities')
local on_attach = require('plugins.config.lsp.on_attach')

local opts = {
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		-- client.resolved_capabilities.document_formatting = false
		vim.api.nvim_create_user_command('DebugNeovim', function()
			require('osv').run_this()
		end, { bang = true })
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
