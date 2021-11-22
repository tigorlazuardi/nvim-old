return function(use)
	use({
		'VonHeikemen/fine-cmdline.nvim',
		requires = {
			{ 'MunifTanjim/nui.nvim' },
		},
		wants = { 'which-key.nvim' },
		config = function()
			local present, _ = pcall(require, 'fine-cmdline')
			if not present then
				return
			end
			local wk = require('which-key')
			wk.register({
				[':'] = { [[<cmd>lua require("fine-cmdline").open()<cr>]], 'Open Command' },
			})
		end,
	})
end
