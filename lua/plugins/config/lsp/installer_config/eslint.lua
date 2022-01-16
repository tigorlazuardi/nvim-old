return {
	on_attach = function(_client, buffer)
		vim.cmd([[
			au BufWritePre <buffer> silent! EslintFixAll
		]])

		local wk = require('which-key')
		wk.register({
			qe = { '<cmd>EslintFixAll<cr>', 'ESLint Fix All' },
		}, { buffer = buffer })
	end,
}
