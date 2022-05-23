local function run()
	require('project_nvim').setup({
		manual_mode = false,
		detection_methods = { 'lsp', 'pattern' },
		patterns = {
			'.git',
			'_darcs',
			'.hg',
			'.bzr',
			'.svn',
			'Makefile',
			'package.json',
			'go.mod',
			'cargo.toml',
			'=src',
		},
		show_hidden = true,
		ignore_lsp = { 'efm', 'null-ls' },
		silent_chdir = true,
	})

	vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files hidden=true<cr>', { desc = 'Find File (Word Search)' })
	vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Live Grep (Word Search)' })
	vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = 'Buffer Picker' })
	vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = 'Help Tags' })
	vim.keymap.set('n', '<leader>fo', '<cmd>Telescope oldfiles<cr>', { desc = 'List Recent Files' })
	vim.keymap.set('n', 'M', '<cmd>Telescope marks<cr>', { desc = 'Show Marks' })

	local trouble = require('trouble.providers.telescope')

	local telescope = require('telescope')

	require('session_manager').setup({
		autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
		autosave_ignore_filetypes = {
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
			'notify',
		},
	})

	-- local fb_actions = require('telescope').extensions.file_browser.actions
	telescope.setup({
		defaults = {
			mappings = {
				['i'] = { ['<c-t>'] = trouble.open_with_trouble },
				['n'] = { ['<c-t>'] = trouble.open_with_trouble },
			},
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
			-- ['ui-select'] = {
			-- 	require('telescope.themes').get_dropdown({}),
			-- },
			-- file_browser = {
			-- 	mappings = {
			-- 		['i'] = {
			-- 			['<c-g>'] = fb_actions.goto_cwd,
			-- 			['<c-h>'] = fb_actions.goto_parent_dir,
			-- 			['<c-b>'] = fb_actions.create,
			-- 			['<c-f>'] = fb_actions.toggle_browser,
			-- 			['<c-i>'] = fb_actions.rename,
			-- 			['<c-x>'] = fb_actions.move,
			-- 			['<c-y>'] = fb_actions.copy,
			-- 			['<c-r>'] = fb_actions.remove,
			-- 			['<c-l>'] = fb_actions.toggle_hidden,
			-- 		},
			-- 		['n'] = {
			-- 			['g'] = fb_actions.goto_cwd,
			-- 			['<c-h>'] = fb_actions.goto_parent_dir,
			-- 			['b'] = fb_actions.create,
			-- 			['f'] = fb_actions.toggle_browser,
			-- 			['<c-i>'] = fb_actions.rename,
			-- 			['x'] = fb_actions.move,
			-- 			['y'] = fb_actions.copy,
			-- 			['r'] = fb_actions.remove,
			-- 			['<c-l>'] = fb_actions.toggle_hidden,
			-- 		},
			-- 	},
			-- },
		},
	})
	telescope.load_extension('projects')
	-- telescope.load_extension('sessions')
	telescope.load_extension('env')
	-- telescope.load_extension('file_browser')

	-- telescope.load_extension('ui-select')
	telescope.load_extension('fzf')

	-- local fb_open = require('telescope').extensions.file_browser.file_browser
	vim.keymap.set('n', '<c-t>', '<cmd>Telescope live_grep<cr>', { desc = 'Live Grep (Word Search)' })
	vim.keymap.set('n', '<c-b>', '<cmd>Telescope buffers<cr>', { desc = 'Buffer Picker' })
	vim.keymap.set('n', '<c-f>', '<cmd>Telescope find_files hidden=true<cr>', { desc = 'File Picker' })
	vim.keymap.set('n', '<leader>fe', '<cmd>Telescope env<cr>', { desc = 'Find Environment Variables' })
end

return function(use)
	use({
		'nvim-telescope/telescope.nvim',
		requires = {
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				run = 'make',
			},
			{ 'ahmedkhalf/project.nvim' },
			{ 'Shatur/neovim-session-manager' },
			{ 'LinArcX/telescope-env.nvim' },
			-- { 'nvim-telescope/telescope-ui-select.nvim' },
		},
		config = run,
	})
end
