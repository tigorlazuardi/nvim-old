return function(use)
	use({
		'mizlan/iswap.nvim',
		config = function()
			require('iswap').setup({})
			vim.keymap.set('n', '<c-s>', '<cmd>ISwapWith<cr>', { desc = 'Swap Nodes' })
		end,
	})
end
