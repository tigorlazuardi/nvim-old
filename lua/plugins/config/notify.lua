return function(use)
	use({
		'rcarriga/nvim-notify',
		setup = function()
			vim.api.nvim_set_option('termguicolors', true)
		end,
		config = function()
			vim.notify = require('notify')
			require('telescope').load_extension('notify')
		end,
	})
end
