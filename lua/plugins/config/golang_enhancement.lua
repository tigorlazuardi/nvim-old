return function(use)
	use({
		'ray-x/go.nvim',
		requires = { 'ray-x/guihua.lua', 'akinsho/nvim-toggleterm.lua' },
		config = function()
			local lsp_installer_servers = require('nvim-lsp-installer.servers')
			local server_available, gopls = lsp_installer_servers.get_server('gopls')
			local path = require('nvim-lsp-installer.path')
			local install_root_dir = path.concat({ vim.fn.stdpath('data'), 'lsp_servers' })
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
				gopls_cmd = { install_root_dir .. '/go/gopls' },
				gofmt = 'gofumpt',
				test_runner = 'richgo',
				run_in_floaterm = true,
				max_line_len = 200, -- Effectively Disable golines
				textobjects = false, -- since this plugin is lazy loaded and only run when a go file is loaded, this will cause E13 read error and had to re-open the file or force save with w! on the opened file to ignore this error.
			})
		end,
		ft = { 'go' },
	})

	use({
		'rafaelsq/nvim-goc.lua',
		config = function()
			require('nvim-goc').setup({})
		end,
		ft = { 'go' },
	})
end
