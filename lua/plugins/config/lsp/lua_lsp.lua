if vim.fn.exepath('lua-language-server') ~= '' then
	local present, lspconfig = pcall(require, 'lspconfig')
	if not present then
		return
	end
	local lib = { vimruntime = true, types = true, plugins = true }
	local configuration = {
		cmd = { 'lua-language-server' },
		on_attach = require('plugins.config.lsp.on_attach'),
		settings = {
			Lua = {
				diagnostics = {
					enable = false,
					globals = {
						'vim',
						'use',
						'awesome',
						'client',
						'root',
						'screen',
						'packer_plugins',
					},
				},
			},
		},
	}

	if vim.fn.has('win32') == 1 then
		local root_path = 'C:/Users/tigor/local/share/lua-language-server/'
		local binary = root_path .. '/bin/Windows/lua-language-server'
		configuration.cmd = { binary, '-E', root_path .. '/main.lua' }
	end
	local coq_present, coq = pcall(require, 'coq')
	if coq_present then
		lspconfig.sumneko_lua.setup(coq.lsp_ensure_capabilities(require('lua-dev').setup({
			library = lib,
			lspconfig = configuration,
		})))
	else
		configuration.capabilities = require('plugins.config.lsp.capabilities')
		lspconfig.sumneko_lua.setup(require('lua-dev').setup({
			library = lib,
			lspconfig = configuration,
		}))
	end
end
