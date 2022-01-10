return function(use)
	use({
		'justinmk/vim-sneak',
		wants = { 'which-key.nvim' },
		after = { 'vim-cutlass' },
		config = function()
			local wk = require('which-key')
			local mappings = {
				s = '<Motion> Sneak Two Chars Forward',
				S = '<Motion> Sneak Two Chars Backward',
				f = { '<Plug>Sneak_f', 'Sneak One Char Forward' },
				F = { '<Plug>Sneak_F', 'Sneak One Char Backward' },
				t = { '<Plug>Sneak_t', 'Sneak (until) One Char Forward' },
				T = { '<Plug>Sneak_T', 'Sneak (until) One Char Backward' },
				[';'] = 'Jump Forward Last Sneak',
				[','] = 'Jump backward Last Sneak',
			}
			wk.register(mappings)
			wk.register(mappings, { mode = 'v' })
			wk.register(mappings, { mode = 'x' })
		end,
	})
end
