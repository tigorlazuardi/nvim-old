return function(use)
	use({
		'folke/which-key.nvim',
		event = 'VimEnter',
		config = function()
			local wk = require('which-key')
			wk.setup({
				plugins = {
					registers = false,
				},
			})

			wk.register({
				['<c-s>'] = { '<cmd>wa<cr>', 'Save All Buffer' },
				H = { '^', 'Move to First Real Character in Line' },
				L = { '$', 'Move to EOL' },
				[']t'] = { '<cmd>bn!<cr>', 'Next Buffer' },
				['[t'] = { '<cmd>bp!<cr>', 'Previous Buffer' },
				['<A-J>'] = { '<cmd>m .+1<cr>==', 'Swap Line Upwards' },
				['<A-K>'] = { '<cmd>m .-2<cr>==', 'Swap Line Downwards' },
			})

			wk.register({ ['?'] = { '<cmd>WhichKey<cr>', 'List Normal Mappings' } })

			wk.register({
				['?'] = {
					name = 'mappings',
					['?'] = { '<cmd>WhichKey<cr>', 'normal' },
					n = { '<cmd>WhichKey<cr>', 'normal' },
					v = { "<cmd>WhichKey '' v<cr>", 'visual' },
					i = { "<cmd>WhichKey '' i<cr>", 'insert' },
					x = { "<cmd>WhichKey '' x<cr>", 'selection' },
				},
			})

			wk.register({
				['<A-j>'] = { '<esc><cmd>m .+1<cr>==gi', 'Swap Line Upwards' },
				['<A-k>'] = { '<esc><cmd>m .-2<cr>==gi', 'Swap Line Downwards' },
			}, {
				mode = 'i',
			})

			wk.register({
				['<A-j>'] = { [[<cmd>m '>+1<cr>gv=gv]], 'Swap Line Upwards' },
				['<A-k>'] = { [[<cmd>m '<-2<cr>gv=gv]], 'Swap Line Downwards' },
			}, {
				mode = 'v',
			})

			wk.register({
				['<leader>p'] = {
					name = 'plugins',
					C = { [[<cmd>PackerClean<cr>]], 'Clean Plugins' },
					c = { [[<cmd>PackerCompile<cr>]], 'Compile Plugins' },
					s = { [[<cmd>PackerStatus<cr>]], 'Plugin Status' },
					i = { [[<cmd>PackerInstall<cr>]], 'Install Missing Plugins' },
					S = { [[<cmd>PackerSync<cr>]], 'Sync Plugins' },
					u = { [[<cmd>PackerUpdate<cr>]], 'Update Plugins' },
					p = { [[<cmd>PackerProfile<cr>]], 'Packer Profile' },
				},
			})

			wk.register({q = {
				'<cmd>WhichKey q<cr>', '+quick'
			}})

			vim.cmd([[
				command! WhichKeyV WhichKey '' v
				command! WhichKeyI WhichKey '' i
			]])
		end,
	})
end
