return function(use)
	use({
		'svermeulen/vim-cutlass',
		config = function()
			local wk = require('which-key')
			wk.register({
				x = { 'd', '(TextObject) Cut' },
				xx = { 'dd', 'Cut Current Line' },
				X = { 'D', 'Cut to EOL' },
			})
			wk.register({
				x = { 'd', '(TextObject) [Selection] Cut' },
			}, { mode = 'x' })
		end,
	})
end
