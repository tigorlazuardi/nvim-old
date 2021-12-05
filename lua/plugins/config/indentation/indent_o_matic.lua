return function(use)
	use({
		'Darazaki/indent-o-matic',
		event = 'VimEnter',
		config = function()
			require('indent-o-matic').setup({})
		end,
	})
end
