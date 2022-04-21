return function(use)
	use({
		'ziontee113/syntax-tree-surfer',
		requires = { 'nvim-treesitter/nvim-treesitter' },
		config = function()
			local wk = require('which-key')

			-- wk.register({
			-- 	['<c-n>'] = {
			-- 		[[<cmd>lua require('syntax-tree-surfer').select_current_node()<cr>]],
			-- 		'Select Current Node',
			-- 	},
			-- 	['<c-m>'] = { [[<cmd>lua require('syntax-tree-surfer').select()<cr>]], 'Select Preview' },
			-- })

			wk.register({
				-- Navigation
				['.'] = { [[<cmd>lua require('syntax-tree-surfer').surf("prev", "visual")<cr>]], 'Surf Previous' },
				[','] = { [[<cmd>lua require('syntax-tree-surfer').surf("next", "visual")<cr>]], 'Surf Next' },
				-- ['<c-m>'] = { [[<cmd>lua require('syntax-tree-surfer').surf("parent", "visual")<cr>]], 'Surf Parent' },
				-- ['<c-n>'] = { [[<cmd>lua require('syntax-tree-surfer').surf("child", "visual")<cr>]], 'Surf Child' },

				-- Swapping
				['<c-h>'] = {
					[[<cmd>lua require('syntax-tree-surfer').surf("prev", "visual", true)<cr>]],
					'Swap Previous',
				},
				['<c-l>'] = {
					[[<cmd>lua require('syntax-tree-surfer').surf("next", "visual", true)<cr>]],
					'Swap Next',
				},
			}, { mode = 'x' })
		end,
	})
end
