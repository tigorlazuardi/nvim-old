return function(use)
	use({
		'junegunn/vim-easy-align',
		wants = { 'which-key.nvim' },
		config = function()
			local wk = require('which-key')
			wk.register({
				gA = { '<Plug>(EasyAlign)', '(TextObject) [Selection] EasyAlign' },
			}, { mode = 'x' })
			wk.register({
				gA = { '<Plug>(EasyAlign)', '(TextObject) EasyAlign' },
			}, { mode = 'n' })
		end,
	})
end
