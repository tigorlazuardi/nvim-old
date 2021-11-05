if vim.fn.exepath('typescript-language-server') ~= '' then
	local present, lspconfig = pcall(require, 'lspconfig')
	if not present then
		return
	end
	local capabilities = require('plugins.config.lsp.capabilities')

	lspconfig.tsserver.setup({
		capabilities = capabilities,
		on_attach = function(client, buffer)
			if client.config.flags then
				client.config.flags.allow_incremental_sync = true
			end
			client.resolved_capabilities.document_formatting = false

			local ts_utils = require('nvim-lsp-ts-utils')

			ts_utils.setup({
				debug = false,
				disable_commands = false,
				enable_import_on_completion = true,

				-- import all
				import_all_timeout = 5000, -- ms
				import_all_priorities = {
					buffers = 4, -- loaded buffer names
					buffer_content = 3, -- loaded buffer content
					local_files = 2, -- git files or files with relative path markers
					same_file = 1, -- add to existing import statement
				},
				import_all_scan_buffers = 100,
				import_all_select_source = false,

				-- eslint
				eslint_enable_code_actions = true,
				eslint_enable_disable_comments = true,
				eslint_bin = 'eslint_d',
				eslint_config_fallback = nil,
				eslint_enable_diagnostics = true,

				-- formatting
				enable_formatting = true,
				formatter = 'prettierd',
				formatter_config_fallback = vim.fn.stdpath('config') .. '/linter-config/.prettierrc.toml',

				-- update imports on file move
				update_imports_on_move = true,
				require_confirmation_on_move = false,
				watch_dir = nil,
			})

			-- required to fix code action ranges
			ts_utils.setup_client(client)

			require('plugins.config.lsp.on_attach')(client, buffer)
		end,
	})
end
