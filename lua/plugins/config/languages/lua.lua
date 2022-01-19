return function(use)
	use({
		'folke/lua-dev.nvim',
		ft = { 'lua' },
		config = function()
			local lsp_installer_servers = require('nvim-lsp-installer.servers')
			local _, sumneko_lua = lsp_installer_servers.get_server('sumneko_lua')
			sumneko_lua:on_ready(function()
				local capabilities = require('plugins.config.lsp.capabilities')
				local on_attach = require('plugins.config.lsp.on_attach')

				local path = require('plenary.path')

				local package_path = vim.split(package.path, ';')
				table.insert(package_path, 'lua/?.lua')
				table.insert(package_path, 'lua/?/init.lua')

				local data = vim.fn.stdpath('data')
				local library = {
					[vim.fn.expand('$VIMRUNTIME')] = true,
					[vim.fn.stdpath('config')] = true,
					[path:new(data, 'site', 'pack', 'packer', 'opt', '*')] = true,
					[path:new(data, 'site', 'pack', 'packer', 'start', '*')] = true,
				}

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
						runtime = {
							version = 'LuaJIT',
							path = package_path,
						},
						completion = { callSnippet = 'Both' },
						workspace = {
							-- Make the server aware of Neovim runtime files
							library = library,
							maxPreload = 2000,
							preloadFileSize = 50000,
						},
						telemetry = {
							enable = false,
						},
					},
					on_new_config = function(config, root)
						local libs = vim.tbl_deep_extend('force', {}, library)
						libs[root] = nil
						config.settings.Lua.workspace.library = libs
						return config
					end,
				}

				-- opts = require('lua-dev').setup({
				-- 	library = { vimruntime = true, types = true, plugins = true },
				-- 	lspconfig = opts,
				-- })
				sumneko_lua:setup(opts)
			end)
			if not sumneko_lua:is_installed() then
				sumneko_lua:install()
			end
		end,
	})
end
