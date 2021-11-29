return function(use)
	use({
		'justinmk/vim-sneak',
		wants = { 'which-key.nvim' },
		config = function()
			local wk = require('which-key')
			wk.register({
				s = '<Motion> Sneak Two Chars Forward',
				S = '<Motion> Sneak Two Chars Backward',
				f = { '<Plug>Sneak_f', 'Sneak One Char Forward' },
				F = { '<Plug>Sneak_F', 'Sneak One Char Backward' },
				t = { '<Plug>Sneak_t', 'Sneak (unTill) One Char Forward' },
				T = { '<Plug>Sneak_T', 'Sneak (unTill) One Char Backward' },
			})
		end,
	})
end
