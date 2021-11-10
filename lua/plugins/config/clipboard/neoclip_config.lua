return function(use)
	use({
		'AckslD/nvim-neoclip.lua',
		require = { 'tami5/sqlite.lua' },
		wants = { 'telescope.nvim', 'which-key.nvim' },
		after = { 'registers.nvim' },
		cond = 'vim.g.is_windows',
		config = function()
			require('neoclip').setup({
				history = 1000,
				enable_persistant_history = true,
				db_path = vim.fn.stdpath('data') .. '/databases/neoclip.sqlite3',
				filter = nil,
				preview = true,
				default_register = { [["]], [[+]], [[*]] },
				on_paste = {
					set_reg = false,
				},
				keys = {
					i = {
						select = 'e',
						paste = '<cr>',
						paste_behind = 'E',
						custom = {},
					},
					n = {
						select = '<cr>',
						paste = 'p',
						paste_behind = 'P',
						custom = {},
					},
				},
			})
			require('telescope').load_extension('neoclip')

			local wk = require('which-key')
			wk.register({
				['<c-r>'] = { [[<cmd>Telescope neoclip<cr>]], 'Open Clipboard Register' },
				-- ['"'] = { [[<cmd>Telescope neoclip<cr>]], 'Open Clipboard Register' },
			})
			-- wk.register({
			-- 	['<c-r>'] = { [[<esc><cmd>Telescope neoclip<cr>]], 'Open Clipboard Register' },
			-- }, {
			-- 	mode = 'i',
			-- })
		end,
	})
end
