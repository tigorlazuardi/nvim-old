return function(use)
	use({
		'ldelossa/litee.nvim',
		requires = {
			'ldelossa/litee-symboltree.nvim',
			-- 'ldelossa/litee-filetree.nvim',
			'ldelossa/litee-calltree.nvim',
		},
		config = function()
			require('litee.lib').setup({
				panel = {
					orientation = 'right',
					panel_size = 40,
				},
			})
			require('litee.calltree').setup({
				on_open = 'panel',
				hide_cursor = false,
			})
			require('litee.symboltree').setup({
				on_open = 'panel',
				hide_cursor = false,
			})
			-- require('litee.filetree').setup({
			-- 	panel = {
			-- 		orientation = 'left',
			-- 		panel_size = 20,
			-- 		hide_cursor = false,
			-- 	},
			-- })
			--
			-- vim.cmd([[au VimEnter * :LTOpenFiletree]])
			--
			-- require('which-key').register({
			-- 	['<leader>e'] = { '<cmd>LTPanel<cr>', 'Toggle Panel' },
			-- })
		end,
	})
end
