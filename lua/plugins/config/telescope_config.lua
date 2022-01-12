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

	if not vim.g.is_windows then
		require('packer').loader('telescope-fzf-native.nvim')
		telescope.load_extension('fzf')
	end

	require('session_manager').setup({
		autoload_mode = require('session_manager.config').AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
	})
	telescope.load_extension('file_browser')
	telescope.load_extension('projects')
	-- telescope.load_extension('sessions')
	telescope.load_extension('env')
	telescope.load_extension('file_browser')
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
				cond = function()
					return not vim.g.is_windows
				end,
			},
			{ 'nvim-telescope/telescope-file-browser.nvim' },
			{ 'ahmedkhalf/project.nvim' },
			{ 'Shatur/neovim-session-manager' },
			{ 'LinArcX/telescope-env.nvim' },
			{ 'nvim-telescope/telescope-file-browser.nvim' },
		},
		config = run,
	})
end
