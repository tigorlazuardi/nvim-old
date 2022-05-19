local capabilities = require('plugins.config.lsp.capabilities')
local server_configuration = {
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = true
		require('plugins.config.lsp.on_attach')(client, bufnr)
		local wk = require('which-key')
		wk.register({
			K = {
				function()
					require('rust-tools.hover_actions').hover_actions()
				end,
				'(LSP) Symbol Definition / Documentation',
			},
		}, { buffer = bufnr })
		vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
			callback = function()
				pcall(vim.lsp.buf.format)
			end,
			buffer = bufnr,
		})
	end,
	settings = {
		['rust-analyzer'] = {
			assist = {
				importEnforceGranularity = true,
				importPrefix = 'by_self',
			},
			checkOnSave = {
				enable = true,
				command = 'clippy',
			},
			cargo = {
				loadOutDirsFromCheck = true,
				autoreload = true,
			},
			procMacro = {
				enable = true,
			},
			diagnostics = {
				disabled = { 'unresolved-proc-macro' },
			},
		},
	},
	capabilities = capabilities,
}

require('lspconfig').rust_analyzer.setup(server_configuration)
local rust_tools = require('rust-tools')
rust_tools.setup({
	server = server_configuration,
})
