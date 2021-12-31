return function(use)
	use({
		'akinsho/flutter-tools.nvim',
		wants = { 'plenary.nvim', 'nvim-lspconfig', 'telescope.nvim', 'nvim-dap' },
		config = function()
			require('telescope').load_extension('flutter')
			require('flutter-tools').setup({
				debugger = {
					enabled = true,
					run_via_dap = true,
				},
				widget_guides = {
					enabled = true,
				},
				lsp = {
					on_attach = function(client, bufnr)
						require('plugins.config.lsp.on_attach')(client, bufnr)

						local wk = require('which-key')
						wk.register({
							['<leader>g'] = {
								name = '+flutter',
								c = {
									"<cmd>require('telescope').extensions.flutter.commands()<cr>",
									'Commands',
								},
								s = {
									'<cmd>FlutterRun<cr>',
									'Run',
								},
								e = {
									'<cmd>FlutterEmulators<cr>',
									'Emulators',
								},
								r = {
									'<cmd>FlutterReload<cr>',
									'Reload',
								},
								R = {
									'<cmd>FlutterRestart<cr>',
									'Restart',
								},
								d = {
									'<cmd>FlutterDevices<cr>',
									'Devices',
								},
								q = {
									'<cmd>FlutterDevices<cr>',
									'Quit',
								},
							},
						}, { buffer = bufnr })
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
