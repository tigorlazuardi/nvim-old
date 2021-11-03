return function(use)
	use({
		'folke/which-key.nvim',
		config = function()
			local wk = require('which-key')
			wk.setup({})

			wk.register({
				['<c-s>'] = { '<cmd>wa<cr>', 'Save All Buffer' },
				H = { '^', 'Move to First Real Character in Line' },
				L = { '$', 'Move to EOL' },
				[']t'] = { '<cmd>bn!<cr>', 'Next Buffer' },
				['[t'] = { '<cmd>bp!<cr>', 'Previous Buffer' },
				['<A-J>'] = { '<cmd>m .+1<cr>==', 'Swap Line Upwards' },
				['<A-K>'] = { '<cmd>m .-2<cr>==', 'Swap Line Downwards' },
			})

			wk.register({
				['<A-J>'] = { '<esc><cmd>m .+1<cr>==gi', 'Swap Line Upwards' },
				['<A-K>'] = { '<esc><cmd>m .-2<cr>==gi', 'Swap Line Downwards' },
			}, {
				mode = 'i',
			})

			wk.register({
				['<A-J>'] = { [[<cmd>m '>+1<cr>gv=gv]], 'Swap Line Upwards' },
				['<A-K>'] = { [[<cmd>m '<-2<cr>gv=gv]], 'Swap Line Downwards' },
			}, {
				mode = 'v',
			})

			vim.cmd([[
				command! WhichKeyV WhichKey '' v
				command! WhichKeyI WhichKey '' i
			]])
		end,
	})
end
