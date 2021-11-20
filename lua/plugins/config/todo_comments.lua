return function(use)
	use({
		'folke/todo-comments.nvim',
		requires = 'nvim-lua/plenary.nvim',
		wants = { 'which-key.nvim' },
		config = function()
			require('todo-comments').setup({
				highlight = { pattern = [[.*<(KEYWORDS)\s*]] },
				search = { pattern = [[\s(KEYWORDS)\b]] },
			})
			require('which-key').register({
				['<leader>td'] = { '<cmd>TodoTelescope<cr>', 'Search Todo' },
			})
		end,
	})
end
