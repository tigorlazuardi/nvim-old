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
						vim.notify('installing gopls...')
						gopls:install()
					end
				end
				require('go').setup({
					gofmt = 'gofumpt',
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
