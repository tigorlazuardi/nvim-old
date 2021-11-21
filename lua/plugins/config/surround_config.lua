return function(use)
	use({
		'blackCauldron7/surround.nvim',
		after = { 'vim-cutlass' },
		config = function()
			local prequire = require('personal.utils.prequire')
			local surround = require('surround')
			surround.setup({
				prefix = 'ss',
			})
			local wk = prequire('which-key')
			if not wk then
				return
			end
			wk.register({
				ss = { 'Surround Prefix' },
			})
		end,
	})
end
