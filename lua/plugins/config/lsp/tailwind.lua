local capabilities = require('plugins.config.lsp.capabilities')
local on_attach = require('plugins.config.lsp.on_attach')

if vim.fn.exepath('tailwindcss-language-server') ~= '' then
	local lspconfig = require('lspconfig')

	lspconfig.tailwindcss.setup({
		capabilities = capabilities,
		-- default filetypes in lspconfig are much bigger. update as necessary to enable on certain filetypes. For now it only activates on filetypes below only.
		filetypes = { 'typescriptreact', 'javascriptreact', 'html', 'css', 'vue', 'svelte' },
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)

			local present, _ = pcall(require, 'headwind')
			if not present then
				return
			end

			local wk = require('which-key')
			local wk_option = { buffer = bufnr }
			wk.register({
				q = {
					name = 'quick',
					s = {
						"<cmd>lua require('headwind').buf_sort_tailwind_classes()<cr>",
						'Sort Tailwind Classes (Buffer)',
					},
				},
			}, wk_option)
			wk.register({
				q = {
					name = 'quick',
					s = {
						"<cmd>lua require('headwind').visual_sort_tailwind_classes()<cr>",
						'Sort Tailwind Classes (Visual)',
					},
				},
			}, {
				buffer = bufnr,
				mode = 'v',
			})
		end,
	})
end
