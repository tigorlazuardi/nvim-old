return function(use)
	use({
		'blackCauldron7/surround.nvim',
		config = function()
			local surround = require('surround')
			surround.setup({
				prefix = 's',
			})
		end,
	})
end
