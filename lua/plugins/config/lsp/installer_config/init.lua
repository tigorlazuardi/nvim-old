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
local lsp_installer_servers = require('nvim-lsp-installer.servers')
local server_available, requested_server = lsp_installer_servers.get_server('sumneko_lua')
if server_available then
	requested_server:on_ready(function()
		local opts = require('plugins.config.lsp.installer_config.lua_lsp')
		requested_server:setup(opts)
	end)
	if not requested_server:is_installed() then
		-- Queue the server to be installed
		requested_server:install()
	end
end

lsp_installer.on_server_ready(function(server)
	local opts = {
		capabilities = capabilities,
		on_attach = on_attach,
	}

	if server.name == 'sumneko_lua' then
		-- opts = require('plugins.config.lsp.installer_config.lua_lsp')
		return
	elseif server.name == 'gopls' then
		opts = require('plugins.config.lsp.installer_config.golang')
	elseif server.name == 'jsonls' then
		opts = require('plugins.config.lsp.installer_config.json')
	elseif server.name == 'tsserver' then
		opts = require('plugins.config.lsp.installer_config.typescript')
	elseif server.name == 'yamlls' then
		opts = require('plugins.config.lsp.installer_config.yaml')
	elseif server.name == 'eslint' then
		-- opts  = require('plugins')
		opts = require('plugins.config.lsp.installer_config.eslint')
	end

	server:setup(opts)
end)
