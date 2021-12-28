return function(use)
	use({
		'beauwilliams/focus.nvim',
		config = function()
			require('focus').setup({
				signcolumn = false, -- disable sign column only on main window
				excluded_filetypes = {
					'calltree',
					'dapui_scopes',
					'dapui_breakpoints',
					'dapui_stacks',
					'dapui_watches',
					'dap-repl',
				},
			})
		end,
		event = 'VimEnter',
	})
end
