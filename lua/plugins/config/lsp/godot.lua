-- require godot and netcat executable to run
if vim.fn.exepath('godot') ~= '' and vim.fn.exepath('nc') ~= '' then
	require('lspconfig').gdscript.setup({
		on_attach = require('plugins.config.lsp.on_attach'),
		capabilities =require('plugins.config.lsp.capabilities')
	})
end
