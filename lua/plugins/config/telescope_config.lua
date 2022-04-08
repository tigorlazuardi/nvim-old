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

	local wk = require('which-key')
	wk.register({
		['<leader>f'] = {
			name = '+find',
			f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", 'Find File' },
			g = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", 'Live Grep (Word Search)' },
			b = { "<cmd>lua require('telescope.builtin').buffers()<cr>", 'Find Buffer' },
			h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", 'List Help Tags' },
			c = { require('personal.telescope.cd'), 'Change Directory' },
			o = { "<cmd>lua require('telescope.builtin').oldfiles()<cr>", 'List Recent Files' },
		},
		M = { '<cmd>Telescope marks<cr>', 'Show Marks' },
	})

	local telescope_mappings = {
		i = {},
		n = {},
	}

	local present, trouble = pcall(require, 'trouble.providers.telescope')
	if present then
		telescope_mappings['i']['<c-t>'] = trouble.open_with_trouble
		telescope_mappings['n']['<c-t>'] = trouble.open_with_trouble
	end

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
	local fb_actions = require('telescope').extensions.file_browser.actions
	telescope.setup({
		defaults = {
			mappings = telescope_mappings,
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
			['ui-select'] = {
				require('telescope.themes').get_dropdown({}),
			},
			file_browser = {
				mappings = {
					['i'] = {
						['<c-h>'] = fb_actions.goto_cwd,
						['<c-g>'] = fb_actions.goto_parent_dir,
						['<c-e>'] = fb_actions.create,
						['<c-f>'] = fb_actions.toggle_browser,
						['<c-i>'] = fb_actions.rename,
						['<c-x>'] = fb_actions.move,
						['<c-y>'] = fb_actions.copy,
						['<c-r>'] = fb_actions.remove,
						['<c-l>'] = fb_actions.toggle_hidden,
					},
					['n'] = {
						['<c-h>'] = fb_actions.goto_cwd,
						['g'] = fb_actions.goto_parent_dir,
						['e'] = fb_actions.create,
						['f'] = fb_actions.toggle_browser,
						['i'] = fb_actions.rename,
						['x'] = fb_actions.move,
						['y'] = fb_actions.copy,
						['r'] = fb_actions.remove,
						['<c-l>'] = fb_actions.toggle_hidden,
					},
				},
			},
		},
	})
	telescope.load_extension('projects')
	-- telescope.load_extension('sessions')
	telescope.load_extension('env')
	telescope.load_extension('file_browser')

	telescope.load_extension('ui-select')
	telescope.load_extension('fzf')
	telescope.load_extension('file_browser')

	local fb_open = require('telescope').extensions.file_browser.file_browser
	wk.register({
		['<leader>e'] = {
			function()
				fb_open({
					path = '%:p:h',
					hidden = true,
					select_buffer = true,
				})
			end,
			'Open File Picker',
		},
		['<c-t>'] = {
			[[<cmd>Telescope buffers<cr>]],
			'Buffer Picker',
		},
	})
end

return function(use)
	use({
		'nvim-telescope/telescope.nvim',
		requires = {
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				run = 'make',
			},
			{ 'nvim-telescope/telescope-file-browser.nvim' },
			{ 'ahmedkhalf/project.nvim' },
			{ 'Shatur/neovim-session-manager' },
			{ 'LinArcX/telescope-env.nvim' },
			{ 'nvim-telescope/telescope-file-browser.nvim' },
			{ 'nvim-telescope/telescope-ui-select.nvim' },
		},
		config = run,
	})
end
