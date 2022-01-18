local capabilities = require('plugins.config.lsp.capabilities')
local on_attach = require('plugins.config.lsp.on_attach')

local path = vim.split(package.path, ';')
table.insert(path, 'lua/?.lua')
table.insert(path, 'lua/?/init.lua')

local library = {}
local function add(lib)
	for _, p in pairs(vim.fn.expand(lib, false, true)) do
		p = vim.loop.fs_realpath(p)
		library[p] = true
	end
end

-- add runtime
add('$VIMRUNTIME')

-- add your config
add('~/.config/nvim')

-- add plugins
-- if you're not using packer, then you might need to change the paths below
add('~/.local/share/nvim/site/pack/packer/opt/*')
add('~/.local/share/nvim/site/pack/packer/start/*')

local opts = {
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		vim.cmd([[command! DebugNeovim lua require('osv').run_this()]])
	end,
	settings = {
		Lua = {
			diagnostics = {
				enable = false,
			},
		},
		runtime = {
			version = 'LuaJIT',
			path = path,
		},
		completion = { callSnippet = 'Both' },
		workspace = {
			-- Make the server aware of Neovim runtime files
			library = library,
			maxPreload = 2000,
			preloadFileSize = 50000,
		},
		telemetry = {
			enable = false,
		},
	},
	on_new_config = function(config, root)
		local libs = vim.tbl_deep_extend('force', {}, library)
		libs[root] = nil
		config.settings.Lua.workspace.library = libs
		return config
	end,
}

-- return require('lua-dev').setup({
-- 	library = { vimruntime = true, types = true, plugins = true },
-- 	lspconfig = opts,
-- })

return opts
