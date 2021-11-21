return function(use)
	use({
		'ggandor/lightspeed.nvim',
		wants = { 'which-key.nvim' },
		after = { 'vim-cutlass' },
		config = function()
			local prequire = require('personal.utils.prequire')
			local lightspeed = prequire('lightspeed')
			if not lightspeed then
				return
			end
			lightspeed.setup({})

			local wk = prequire('which-key')

			wk.register({
				s = { '<Plug>Lightspeed_s', 'Search 2 Char Forward' },
				S = { '<Plug>Lightspeed_S', 'Search 2 Char Backward' },
				x = { '<Plug>Lightspeed_x', 'X-Mode 2 Char Forward' },
				X = { '<Plug>Lightspeed_X', 'X-Mode 2 Char Backward' },
				f = { '<Plug>Lightspeed_f', 'Move to 1 Char Forward' },
				F = { '<Plug>Lightspeed_f', 'Move to 1 Char Backward' },
				t = { '<Plug>Lightspeed_t', 'Move until 1 Char Forward' },
				T = { '<Plug>Lightspeed_T', 'Move until 1 Char Backward' },
				[';'] = { '<Plug>Lightspeed_;_ft', 'Repeat Last Move Forward' },
				[','] = { '<Plug>Lightspeed_,_ft', 'Repeat Last Move Backward' },
			})
		end,
	})
end
