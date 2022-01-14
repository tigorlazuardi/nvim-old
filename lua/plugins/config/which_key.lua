return function(use)
	use({
		'folke/which-key.nvim',
		config = function()
			local wk = require('which-key')
			wk.setup({
				plugins = {
					registers = false,
				},
			})

			wk.register({
				['<c-s>'] = { '<cmd>wa<cr>', 'Save All Buffer' },
				[']t'] = { '<cmd>bn!<cr>', 'Next Buffer' },
				['[t'] = { '<cmd>bp!<cr>', 'Previous Buffer' },
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
				['<leader>p'] = {
					name = 'plugins',
					C = { [[<cmd>PackerClean<cr>]], 'Clean Plugins' },
					c = { [[<cmd>PackerCompile<cr>]], 'Compile Plugins' },
					s = { [[<cmd>PackerStatus<cr>]], 'Plugin Status' },
					i = { [[<cmd>PackerInstall<cr>]], 'Install Missing Plugins' },
					S = { [[<cmd>PackerSync<cr>]], 'Sync Plugins' },
					u = { [[<cmd>PackerUpdate<cr>]], 'Update Plugins' },
					p = { [[<cmd>PackerProfile<cr>]], 'Packer Profile' },
					R = {
						function()
							dofile(vim.fn.stdpath('config') .. '/init.lua')
							print('Reloaded configurations')
						end,
						'Reload Config',
					},
				},
			}, { silent = false })

			wk.register({ q = {
				'<cmd>WhichKey q<cr>',
				'+quick',
			} })

			vim.cmd([[
				command! WhichKeyV WhichKey '' v
				command! WhichKeyI WhichKey '' i
			]])
		end,
	})
end
