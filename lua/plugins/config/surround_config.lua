return function(use)
	use({
		'blackCauldron7/surround.nvim',
		after = { 'vim-cutlass' },
		config = function()
			local prequire = require('personal.utils.prequire')
			local surround = require('surround')
			surround.setup({
				prefix = 'q',
			})
			local wk = prequire('which-key')
			if not wk then
				return
			end

			wk.register({
				qa = 'Add Surround <Motion>',
				qq = 'Repeat Last Surround',
				qd = 'Delete Surround <Motion>',
				qr = 'Replace Surround <Motion>',
				qt = {
					name = 'toggle brackets',
					b = 'Toggle Brackets',
					q = 'Toggle Quotes',
					B = 'Toggle Brackets',
				},
			})
		end,
	})
end
