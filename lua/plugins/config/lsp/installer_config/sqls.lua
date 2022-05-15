local util = require('packer.util')
local install_root_dir = util.join_paths(vim.fn.stdpath('data'), 'lsp_servers')

local opts = {
	cmd = { install_root_dir .. '/sqls/sqls', '-config', vim.fn.expand('$HOME/.config/sqls/config.yml') },
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		require('sqls').on_attach(client, bufnr)
	end,
}

return opts
