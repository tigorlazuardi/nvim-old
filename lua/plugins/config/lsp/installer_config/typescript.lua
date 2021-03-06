local capabilities = require('plugins.config.lsp.capabilities')
local on_attach = require('plugins.config.lsp.on_attach')

local opts = {
	capabilities = capabilities,
	init_options = require('nvim-lsp-ts-utils').init_options,
	on_attach = function(client, bufnr)
		if client.config.flags then
			client.config.flags.allow_incremental_sync = true
		end
		client.server_capabilities.documentFormattingProvider = false

		local ts_utils = require('nvim-lsp-ts-utils')

		ts_utils.setup({
			debug = false,
			disable_commands = false,
			enable_import_on_completion = true,

			-- import all
			import_all_timeout = 5000, -- ms
			auto_inlay_hints = true,
			import_all_priorities = {
				buffers = 4, -- loaded buffer names
				buffer_content = 3, -- loaded buffer content
				local_files = 2, -- git files or files with relative path markers
				same_file = 1, -- add to existing import statement
			},
			import_all_scan_buffers = 100,
			import_all_select_source = false,
			-- update imports on file move
			update_imports_on_move = true,
			require_confirmation_on_move = true,
			watch_dir = nil,
			inlay_hints_format = { -- format options for individual hint kind
				Parameter = {
					highlight = 'Comment',
					text = function(_text)
						return ''
					end,
				},
				Enum = {
					highlight = 'Comment',
					text = function(_text)
						return ''
					end,
				},
				-- Example format customization for `Type` kind:
				Type = {
					highlight = 'Comment',
					text = function(text)
						return '<-' .. text:sub(2)
					end,
				},
			},
		})

		-- required to fix code action ranges
		ts_utils.setup_client(client)

		on_attach(client, bufnr)

		local wk = require('which-key')
		wk.register({
			['<leader>g'] = {
				name = '+web',
				f = { '<cmd>TSLspOrganize<CR>', 'Organize Import' },
				r = { '<cmd>TSLspRenameFile<CR>', 'Rename File' },
				i = { '<cmd>TSLspImportAll<CR>', 'Import All' },
			},
		}, { buffer = bufnr })
	end,
}

require('lspconfig').tsserver.setup(opts)
