local function rust_tools_config()
	local path = require('plenary.path')
	local capabilities = require('plugins.config.lsp.capabilities')
	local server_configuration = {
		on_attach = function(client, bufnr)
			client.resolved_capabilities.document_formatting = true
			require('plugins.config.lsp.on_attach')(client, bufnr)
			local wk = require('which-key')
			wk.register({
				K = {
					function()
						require('personal.utils.with_fold_check')(require('rust-tools.hover_actions').hover_actions)
					end,
					'(LSP) Symbol Definition / Documentation',
				},
			}, { buffer = bufnr })
			vim.cmd([[
					au BufWritePre <buffer> silent! lua vim.lsp.buf.formatting_sync() 
				]])
		end,
		settings = {
			['rust-analyzer'] = {
				assist = {
					importEnforceGranularity = true,
					importPrefix = 'by_self',
				},
				checkOnSave = {
					enable = true,
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

	local exec_name = 'rust_analyzer'
	if vim.g.is_windows then
		exec_name = exec_name .. '.exe'
	end

	local lsp_installer_servers = require('nvim-lsp-installer.servers')
	local server_available, rust_analyzer = lsp_installer_servers.get_server('rust_analyzer')
	if server_available then
		rust_analyzer:on_ready(function()
			server_configuration.cmd = { path:new(rust_analyzer.root_dir, exec_name).filename }
			local rust_tools = require('rust-tools')
			rust_tools.setup({
				server = server_configuration,
			})
		end)

		if not rust_analyzer:is_installed() then
			rust_analyzer:install()
		end
	end
end

return function(use)
	use({
		'simrat39/rust-tools.nvim',
		wants = { 'nvim-lspconfig', 'which-key.nvim' },
		config = rust_tools_config,
		ft = { 'rust' },
	})
end
