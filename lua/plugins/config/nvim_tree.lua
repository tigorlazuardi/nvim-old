local function setup()
	-- vim.g.nvim_tree_follow = 1
	vim.g.nvim_tree_git_hl = 1
	-- vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.cache' }
	vim.g.nvim_tree_window_picker_exclude = {
		filetype = {
			'packer',
			'qf',
			'Trouble',
			'TelescopePrompt',
			'Outline',
			'dapui_scopes',
			'dapui_breakpoints',
			'dapui_stacks',
			'dapui_watches',
			'dapui_repl',
			'dap_repl',
		},
		buftype = { 'terminal' },
	}
	vim.g.nvim_tree_highlight_opened_files = 3

	vim.g.nvim_tree_icons = {
		default = '',
		symlink = '',
		git = {
			unstaged = '',
			staged = '✓',
			unmerged = '',
			renamed = '➜',
			untracked = '',
			deleted = '',
			ignored = '◌',
		},
		folder = {
			arrow_open = '',
			arrow_closed = '',
			default = '',
			open = '',
			empty = '',
			empty_open = '',
			symlink = '',
			symlink_open = '',
		},
		lsp = { hint = '', info = '', warning = '', error = '' },
	}
	vim.g.nvim_tree_special_files = {
		['README.md'] = 1,
		Makefile = 1,
		MAKEFILE = 1,
		['readme.md'] = 1,
		['CHANGELOG.md'] = 1,
	}
end

local function run()
	require('nvim-tree').setup({
		update_cwd = true,
		diagnostics = {
			enable = true,
			icons = {
				hint = '',
				info = '',
				warning = '',
				error = '',
			},
		},
		open_on_setup = true,
		ignore_ft_on_setup = {},
		git = {
			enable = true,
			ignore = false,
			timeout = 500,
		},
		update_focused_file = {
			enable = true,
			update_cwd = true,
		},
		filters = {
			custom = { 'node_modules', 'target', '.git' },
		},
		view = {
			width = 40,
			hide_root_folder = true,
			auto_resize = true,
		},
	})

	local wk = require('which-key')

	wk.register({
		['<leader>'] = {
			e = { '<cmd>NvimTreeToggle<cr>', 'Toggle Explorer' },
			tt = { '<cmd>NvimTreeToggle<cr>', 'Toggle Explorer' },
			tr = { '<cmd>NvimTreeRefresh<cr>', 'Refresh Explorer Window' },
			tn = { '<cmd>NvimTreeFindFile<cr>', 'Find File in Explorer' },
		},
	})

	vim.cmd([[hi! link NvimTreeGitDirty GitSignsChange]])
	vim.cmd([[hi! link NvimTreeGitNew GitSignsAdd]])
end

return function(use)
	use({
		'kyazdani42/nvim-tree.lua',
		requires = 'kyazdani42/nvim-web-devicons',
		setup = setup,
		config = run,
		wants = { 'which-key.nvim' },
	})
end
