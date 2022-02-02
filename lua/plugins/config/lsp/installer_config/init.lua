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
local server_available, sumneko_lua = lsp_installer_servers.get_server('sumneko_lua')
if server_available then
	sumneko_lua:on_ready(function()
		local opts = require('plugins.config.lsp.installer_config.lua_lsp')
		sumneko_lua:setup(opts)
	end)
	if not sumneko_lua:is_installed() then
		sumneko_lua:install('v2.5.6')
	end
end

local blacklist = { sumneko_lua = true, gopls = true, rust_analyzer = true, dartls = true }

---check if blacklist
---@param value string value to check against
---@return boolean
function blacklist:has(value)
	return blacklist[value] or false
end

lsp_installer.on_server_ready(function(server)
	local opts = {
		capabilities = capabilities,
		on_attach = on_attach,
	}

	if blacklist:has(server.name) then
		return
	end

	if server.name == 'jsonls' then
		opts = require('plugins.config.lsp.installer_config.json')
	elseif server.name == 'tsserver' then
		opts = require('plugins.config.lsp.installer_config.typescript')
	elseif server.name == 'yamlls' then
		opts = require('plugins.config.lsp.installer_config.yaml')
	elseif server.name == 'eslint' then
		opts = require('plugins.config.lsp.installer_config.eslint')
	end

	server:setup(opts)
end)
