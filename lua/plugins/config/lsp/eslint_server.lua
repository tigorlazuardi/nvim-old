if vim.fn.exepath('vscode-eslint-language-server') then
	require('lspconfig').eslint.setup({
		on_attach = function(_client, buffer)
			local prequire = require('personal.utils.prequire')
			vim.cmd([[
				augroup eslint_format
					au!
					au BufWritePre <buffer> EslintFixAll
				augroup end
			]])

			local wk = prequire('which-key')
			if not wk then
				return
			end

			wk.register({
				qe = { '<cmd>EslintFixAll<cr>', 'ESLint Fix All' },
			}, { buffer = buffer })
		end,
	})
end
