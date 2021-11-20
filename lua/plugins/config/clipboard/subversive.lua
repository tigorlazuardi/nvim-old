return function(use)
	use({
		'svermeulen/vim-subversive',
		wants = { 'which-key.nvim' },
		config = function()
			local wk = require('which-key')
			wk.register({
				['<leader>s'] = { '<Plug>(SubversiveSubstitute)', 'Substitute (Motion)' },
				['<leader>ss'] = { '<Plug>(SubversiveSubstituteLine)', 'Substitute Line' },
				['<leader>sw'] = { '<plug>(SubversiveSubstituteToEndOfLine)', 'Substitute to End of Line' },
			})
		end,
	})
end
