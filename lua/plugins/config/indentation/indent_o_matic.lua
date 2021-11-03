return function(use)
	use({
		'Darazaki/indent-o-matic',
		config = function()
			require('indent-o-matic').setup({})
		end,
	})
end
