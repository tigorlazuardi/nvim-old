return function(use)
	use({
		'machakann/vim-sandwich',
		setup = function()
			vim.g.sandwich_no_default_key_mappings = 1
		end,
		config = function()
			local wk = require('which-key')
			local mappings = {
				q = {
					name = 'quick',
					a = { '<Plug>(operator-sandwich-add)', 'Operator Sandwich Add' },
					d = { '<Plug>(operator-sandwich-delete)', 'Operator Sandwich Delete' },
					r = { '<Plug>(operator-sandwich-replace)', 'Operator Sandwich Replace' },
				},
			}
			wk.register(mappings)
			wk.register(mappings, { mode = 'v' })
		end,
	})
end
