local on_attach = require('plugins.config.lsp.on_attach')
local capabilities = require('plugins.config.lsp.capabilities')

if vim.fn.exepath('godot') ~= '' then
	local configs = require('lspconfig/configs')
	local lspconfig = require('lspconfig')
	local util = require('lspconfig/util')
	local wk = require('which-key')

	local config_def = {
		cmd = { 'godot' },
		filetypes = { 'gdscript' },
		name = 'godot',
		root_dir = function(name)
			return util.root_pattern('project.godot')(name) or util.path.dirname(name)
		end,
		autostart = false,
	}

	configs.godot = {
		default_config = config_def,
	}

	lspconfig.godot.setup({
		capabilities = capabilities,
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
		end,
	})
end
