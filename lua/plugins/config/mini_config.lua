return function(use)
	use({
		'echasnovski/mini.nvim',
		config = function()
			require('mini.indentscope').setup({})
		end,
	})
end
