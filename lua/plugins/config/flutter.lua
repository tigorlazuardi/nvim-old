return function(use)
	use({
		'akinsho/flutter-tools.nvim',
		wants = { 'plenary.nvim', 'nvim-lspconfig', 'telescope.nvim', 'nvim-dap' },
		config = function()
			local ok, telescope = pcall(require, 'telescope')
			if ok then
				telescope.load_extension('flutter')
			end

			local lsp_installer_servers = require('nvim-lsp-installer.servers')
			local server_available, dartls = lsp_installer_servers.get_server('dartls')
			if server_available then
				dartls:on_ready(function()
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
								local wk = require('which-key')
								wk.register({
									['<leader>g'] = {
										name = '+flutter',
										c = {
											'<cmd>Telescope flutter commands<cr>',
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
										t = {
											'<cmd>FlutterDevTools<cr>',
											'Dev Tools',
										},
										y = {
											'<cmd>FlutterCopyProfileUrl<cr>',
											'Copy Profile URL',
										},
										b = {
											'<cmr>FlutterLspRestart<cr>',
											'LSP Restart',
										},
									},
									gs = { '<cmd>FlutterOutlineToggle<cr>', 'Widget Outline' },
								}, { buffer = bufnr })
							end,
							capabilities = require('plugins.config.lsp.capabilities'), -- e.g. lsp_status capabilities
							settings = {
								showTodos = true,
								completeFunctionCalls = true,
							},
						},
					})
				end)
				if not dartls:is_installed() then
					dartls:install()
				end
			end
		end,
		ft = { 'dart' },
	})
end
