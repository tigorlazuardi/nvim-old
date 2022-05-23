return function(use)
	use({
		'akinsho/flutter-tools.nvim',
		requires = {
			'nvim-telescope/telescope.nvim',
			'neovim/nvim-lspconfig',
			'mfussenegger/nvim-dap',
			'nvim-lua/plenary.nvim',
		},
		config = function()
			local telescope = require('telescope')
			telescope.load_extension('flutter')

			require('flutter-tools').setup({
				debugger = {
					enabled = true,
					run_via_dap = false,
				},
				widget_guides = {
					enabled = true,
				},
				lsp = {
					on_attach = function(client, bufnr)
						require('plugins.config.lsp.on_attach')(client, bufnr)

						local function map(key, command, desc)
							vim.keymap.set(
								'n',
								'<leader>g' .. key,
								command,
								{ desc = 'Flutter ' .. desc, buffer = bufnr }
							)
						end
						map('c', '<cmd>Telescope flutter commands<cr>', 'Commands')
						map('s', '<cmd>FlutterRun<cr>', 'Run')
						map('e', '<cmd>FlutterEmulators<cr>', 'Emulators')
						map('r', '<cmd>FlutterReload<cr>', 'Reload')
						map('R', '<cmd>FlutterRestart<cr>', 'Restart')
						map('d', '<cmd>FlutterDevices<cr>', 'Devices')
						map('q', '<cmd>FlutterQuit<cr>', 'Quit')
						map('t', '<cmd>FlutterDevTools<cr>', 'Dev Tools')
						map('y', '<cmd>FlutterCopyProfileUrl<cr>', 'Copy Profile URL')
						map('b', '<cmd>FlutterLspRestart', 'LSP Restart')
						vim.keymap.set(
							'n',
							'gs',
							'<cmd>FlutterOutlineToggle<cr>',
							{ desc = 'Flutter Widget Outline', buffer = bufnr }
						)
					end,
					capabilities = require('plugins.config.lsp.capabilities'), -- e.g. lsp_status capabilities
					settings = {
						showTodos = true,
						completeFunctionCalls = true,
					},
				},
			})
		end,
		ft = { 'dart' },
	})
end
