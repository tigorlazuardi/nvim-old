return function(use)
	use({
		'gbprod/cutlass.nvim',
		config = function()
			require('cutlass').setup({
				cut_key = 'x',
			})
		end,
	})
end
