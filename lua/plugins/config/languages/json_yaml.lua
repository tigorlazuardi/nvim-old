return function(use)
	use({
		'b0o/schemastore.nvim',
		ft = { 'yaml', 'json', 'yml' },
		config = function()
			local lsp_installer_servers = require('nvim-lsp-installer.servers')
			local _, yamlls = lsp_installer_servers.get_server('yamlls')
			local _, jsonls = lsp_installer_servers.get_server('jsonls')
			local capabilities = require('plugins.config.lsp.capabilities')
			local on_attach = require('plugins.config.lsp.on_attach')
			local function opts_gen(settings)
				return {
					capabilities = capabilities,
					on_attach = function(client, bufnr)
						client.resolved_capabilities.document_formatting = false
						on_attach(client, bufnr)
					end,
					settings = settings,
				}
			end
			yamlls:on_ready(function()
				yamlls:setup(opts_gen({
					yaml = {
						schemas = require('schemastore').json.schemas(),
					},
				}))
			end)
			jsonls:on_ready(function()
				jsonls:setup(opts_gen({
					json = {
						schemas = require('schemastore').json.schemas(),
					},
				}))
			end)
			if not yamlls:is_installed() then
				yamlls:install()
			end
			if not jsonls:is_installed() then
				jsonls:install()
			end
		end,
	})
end
