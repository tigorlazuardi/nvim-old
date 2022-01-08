return function(use)
	use({
		'anuvyklack/pretty-fold.nvim',
		config = function()
			require('pretty-fold').setup({})
		end,
	})
end
