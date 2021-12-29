return function(use)
	vim.g.registers_delay = 0
	use({
		'tversteeg/registers.nvim',
		config = function()
			local wk = require('which-key')
			wk.register({
				['"'] = { 'Clipboard Registers' },
			})
		end,
	})
end
