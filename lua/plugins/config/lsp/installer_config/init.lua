local lsp_installer = require('nvim-lsp-installer')
lsp_installer.settings({
	ui = {
		icons = {
			server_installed = '✓',
			server_pending = '➜',
			server_uninstalled = '✗',
		},
	},
})

local capabilities = require('plugins.config.lsp.capabilities')
local on_attach = require('plugins.config.lsp.on_attach')

lsp_installer.on_server_ready(function(server)
	local opts = {
		capabilities = capabilities,
		on_attach = on_attach,
	}

	if server.name == 'sumneko_lua' then
		opts = require('plugins.config.lsp.installer_config.lua_lsp')
	elseif server.name == 'gopls' then
		opts = require('plugins.config.lsp.installer_config.golang')
	elseif server.name == 'jsonls' then
		opts = require('plugins.config.lsp.installer_config.json')
	elseif server.name == 'tsserver' then
		opts = require('plugins.config.lsp.installer_config.typescript')
	elseif server.name == 'yamlls' then
		opts = require('plugins.config.lsp.installer_config.yaml')
	end

	server:setup(opts)
end)
