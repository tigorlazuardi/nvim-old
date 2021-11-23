if vim.fn.exepath('vscode-json-languageserver') ~= '' then
	require('lspconfig').jsonls.setup({
		cmd = { 'vscode-json-languageserver', '--stdio' },
		commands = {
			Format = {
				function()
					vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line('$'), 0 })
				end,
			},
		},
		settings = {
			json = {
				schemas = {
					{
						description = 'TypeScript compiler configuration file',
						fileMatch = { 'tsconfig.json', 'tsconfig.*.json' },
						url = 'http://json.schemastore.org/tsconfig',
					},
					{
						description = 'Lerna config',
						fileMatch = { 'lerna.json' },
						url = 'http://json.schemastore.org/lerna',
					},
					{
						description = 'Babel configuration',
						fileMatch = { '.babelrc.json', '.babelrc', 'babel.config.json' },
						url = 'http://json.schemastore.org/lerna',
					},
					{
						description = 'ESLint config',
						fileMatch = { '.eslintrc.json', '.eslintrc' },
						url = 'http://json.schemastore.org/eslintrc',
					},
					{
						description = 'Bucklescript config',
						fileMatch = { 'bsconfig.json' },
						url = 'https://bucklescript.github.io/bucklescript/docson/build-schema.json',
					},
					{
						description = 'Prettier config',
						fileMatch = { '.prettierrc', '.prettierrc.json', 'prettier.config.json' },
						url = 'http://json.schemastore.org/prettierrc',
					},
					{
						description = 'Vercel Now config',
						fileMatch = { 'now.json' },
						url = 'http://json.schemastore.org/now',
					},
					{
						description = 'Stylelint config',
						fileMatch = { '.stylelintrc', '.stylelintrc.json', 'stylelint.config.json' },
						url = 'http://json.schemastore.org/stylelintrc',
					},
				},
			},
		},
		on_attach = function(client, bufnr)
			client.resolved_capabilities.document_formatting = false
			require('plugins.config.lsp.on_attach')(client, bufnr)
		end,
		capabilities = require('plugins.config.lsp.capabilities'),
	})
end
