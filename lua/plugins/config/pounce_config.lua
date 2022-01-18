return function(use)
	use({
		'rlane/pounce.nvim',
		setup = function()
			vim.defer_fn(function()
				local wk = require('which-key')

				local mappings = {
					s = { '<cmd>Pounce<cr>', 'Pounce' },
				}

				wk.register(mappings)
				wk.register(mappings, { mode = 'v' })
				wk.register({ gs = { '<cmd>Pounce<cr>', 'Pounce' } }, { mode = 'o' })
			end, 300)
		end,
	})
end
