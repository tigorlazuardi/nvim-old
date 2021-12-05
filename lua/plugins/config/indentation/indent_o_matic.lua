return function(use)
	use({
		'Darazaki/indent-o-matic',
		event = 'BufReadPre',
		config = function()
			require('indent-o-matic').setup({})
		end,
	})
end
