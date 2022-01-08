local function rust_tools_config()
	if vim.fn.exepath('rust-analyzer') ~= '' then
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
		}

		local rust_tools = require('rust-tools')
		local coq_present, coq = pcall(require, 'coq')
		-- local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.6.7/'
		-- local codelldb_path = extension_path .. 'adapter/codelldb'
		-- local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

		-- local dap = { adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path) }

		if coq_present then
			rust_tools.setup({
				server = coq.lsp_ensure_capabilities(server_configuration),
				-- dap = dap,
			})
		else
			server_configuration.capabilities = require('plugins.config.lsp.capabilities')
			rust_tools.setup({
				server = server_configuration,
				-- dap = dap,
			})
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
