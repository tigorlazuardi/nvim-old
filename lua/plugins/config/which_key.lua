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
				[']t'] = { '<cmd>bn!<cr>', 'Next Buffer' },
				['[t'] = { '<cmd>bp!<cr>', 'Previous Buffer' },
			})

			wk.register({
				['g?'] = {
					name = 'mappings',
					['?'] = { '<cmd>WhichKey<cr>', 'normal' },
					n = { '<cmd>WhichKey<cr>', 'normal' },
					v = { "<cmd>WhichKey '' v<cr>", 'visual' },
					i = { "<cmd>WhichKey '' i<cr>", 'insert' },
					x = { "<cmd>WhichKey '' x<cr>", 'selection' },
				},
			})

			wk.register({
				['?'] = { '<cmd>WhichKey<cr>', 'mappings' },
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
							vim.cmd([[source ]] .. vim.fn.stdpath('config') .. '/init.lua')
							vim.notify('Reloaded Configuration')
						end,
						'Reload Config',
					},
				},
			}, { silent = false })

			wk.register({ ['<leader>q'] = {
				'<cmd>WhichKey q<cr>',
				'+quick',
			} })

			vim.api.nvim_create_user_command('WhichKeyV', [[WhichKey '' v]], { bang = true })
			vim.api.nvim_create_user_command('WhichKeyI', [[WhichKey '' i]], { bang = true })
		end,
	})
end
