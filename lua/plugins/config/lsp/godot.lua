if not vim.g.use_godot_lsp then
	return
end

if vim.fn.exepath('godot') ~= '' and vim.fn.exepath('nc') == '' then
	print('godot is installed but netcat is not installed. please install net cat to continue')
end

-- require godot and netcat executable to run
if vim.fn.exepath('godot') ~= '' and vim.fn.exepath('nc') ~= '' then
	require('lspconfig').gdscript.setup({
		on_attach = require('plugins.config.lsp.on_attach'),
		capabilities = require('plugins.config.lsp.capabilities'),
	})
end
