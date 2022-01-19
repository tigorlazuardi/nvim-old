return function(use)
	if vim.fn.exepath('gopls') ~= '' then
		use({
			'ray-x/go.nvim',
			requires = { 'ray-x/guihua.lua' },
			config = function()
				local lsp_installer_servers = require('nvim-lsp-installer.servers')
				local server_available, gopls = lsp_installer_servers.get_server('gopls')
				if server_available then
					gopls:on_ready(function()
						local opts = require('plugins.config.lsp.installer_config.golang')
						gopls:setup(opts)
					end)

					if not gopls:is_installed() then
						gopls:install()
					end
				end
				require('go').setup({
					gofmt = 'gofumpt',
					max_line_len = 120, -- max line length in goline format
					tag_transform = false, -- tag_transfer  check gomodifytags for details
					verbose = false, -- output loginf in messages
					lsp_cfg = false, -- true: apply go.nvim non-default gopls setup
					lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
					lsp_on_attach = require('plugins.config.lsp.on_attach'),
					lsp_diag_hdlr = true, -- hook lsp diag handler
					dap_debug = false, -- set to true to enable dap
					dap_debug_keymap = true, -- set keymaps for debugger
					dap_debug_gui = true, -- set to true to enable dap gui, highly recommended
					dap_debug_vt = true, -- set to true to enable dap virtual text
				})
			end,
			ft = { 'go' },
		})
	end

	use({
		'rafaelsq/nvim-goc.lua',
		config = function()
			require('nvim-goc').setup({})

			require('which-key').register({
				['<leader>g'] = {
					name = '+go',
					c = {
						function()
							require('nvim-goc').ClearCoverage()
						end,
						'Clear Coverage',
					},
					r = {
						function()
							require('nvim-goc').Coverage()
						end,
						'Coverage',
					},
					t = {
						function()
							require('nvim-goc').CoverageFunc()
						end,
						'Coverage Func',
					},
				},
			})
		end,
		ft = { 'go' },
	})

	use({
		'edolphin-ydf/goimpl.nvim',
		config = function()
			local ok, telescope = pcall(require, 'telescope')
			if not ok then
				return
			end

			telescope.load_extension('goimpl')
		end,
		ft = { 'go' },
	})
end
