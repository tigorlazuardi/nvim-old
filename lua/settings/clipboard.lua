vim.o.clipboard = vim.o.clipboard .. 'unnamedplus'

local highlight_yank = vim.api.nvim_create_augroup('highlight_yank', { clear = true })
vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
	pattern = { '*' },
	callback = function()
		require('vim.highlight').on_yank()
	end,
	desc = 'Triggers highlight on yanked content briefly',
	group = highlight_yank,
})
