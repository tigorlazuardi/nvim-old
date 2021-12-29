local signs_config = function()
	require('gitsigns').setup({
		signs = {
			add = {
				hl = 'GitSignsAdd',
				text = '│',
				numhl = 'GitSignsAddNr',
				linehl = 'GitSignsAddLn',
			},
			change = {
				hl = 'GitSignsChange',
				text = '│',
				numhl = 'GitSignsChangeNr',
				linehl = 'GitSignsChangeLn',
			},
			delete = {
				hl = 'GitSignsDelete',
				text = '_',
				numhl = 'GitSignsDeleteNr',
				linehl = 'GitSignsDeleteLn',
			},
			topdelete = {
				hl = 'GitSignsDelete',
				text = '‾',
				numhl = 'GitSignsDeleteNr',
				linehl = 'GitSignsDeleteLn',
			},
			changedelete = {
				hl = 'GitSignsChange',
				text = '~',
				numhl = 'GitSignsChangeNr',
				linehl = 'GitSignsChangeLn',
			},
		},
		numhl = false,
		linehl = false,
		keymaps = {
			-- Default keymap options
			noremap = true,
			buffer = true,

			['n ]c'] = {
				expr = true,
				"&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'",
			},
			['n [c'] = {
				expr = true,
				"&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'",
			},

			['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
			['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
			['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
			['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
			['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
			['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
			['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
			['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',

			-- Text objects
			['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
			['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
		},
		watch_gitdir = { interval = 1000, follow_files = true },
		current_line_blame = true,
		current_line_blame_opts = {
			delay = 500,
			virt_text_pos = 'eol',
		},
		sign_priority = 6,
		update_debounce = 100,
		status_formatter = nil, -- Use default
		word_diff = false,
		-- use_decoration_api = true,
		diff_opts = { internal = true },
	})

	local wk = require('which-key')

	wk.register({
		['<leader>h'] = {
			name = 'gitsigns',
			s = { 'Stage Hunk' },
			u = { 'Undo Stage Hunk' },
			r = { 'Reset Hunk' },
			R = { 'Reset Buffer' },
			p = { 'Preview Hunk' },
			b = { 'Blame Line' },
		},
	})
end

return function(use)
	use({
		'lewis6991/gitsigns.nvim',
		config = signs_config,
		cond = function()
			return not vim.g.is_windows
		end,
	})
end
