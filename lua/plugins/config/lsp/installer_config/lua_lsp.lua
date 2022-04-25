local capabilities = require('plugins.config.lsp.capabilities')
local on_attach = require('plugins.config.lsp.on_attach')

local opts = {
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
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

if vim.startswith(vim.fn.getcwd(0), vim.fn.stdpath('config')) then
	return require('lua-dev').setup({
		library = { vimruntime = true, types = true, plugins = true },
		lspconfig = opts,
	})
end

return opts
