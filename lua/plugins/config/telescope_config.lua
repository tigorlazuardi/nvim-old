local function run()
	local wk = require('which-key')
	wk.register({
		['<leader>f'] = {
			name = '+find',
			f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", 'Find File' },
			g = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", 'Live Grep (Word Search)' },
			b = { "<cmd>lua require('telescope.builtin').buffers()<cr>", 'Find Buffer' },
			h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", 'List Help Tags' },
		},
		['<leader><leader>'] = {
			"<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>",
			'Recent Files',
		},
	})

	local actions = require('telescope.actions')
	local telescope_mappings = {
		i = { ['<esc>'] = actions.close },
	}

	local present, trouble = pcall(require, 'trouble.providers.telescope')
	if present then
		telescope_mappings['i']['<c-t>'] = trouble.open_with_trouble
		telescope_mappings['n'] = { ['<c-t>'] = trouble.open_with_trouble }
	end
	local telescope = require('telescope')
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
	if not _G.is_windows() then
		telescope.load_extension('fzf')
		telescope.load_extension('frecency')
	end
end

return function(use)
	use({'nvim-lua/plenary.nvim'})
	use({
		'nvim-telescope/telescope.nvim',
		requires = {
			{ 'nvim-lua/popup.nvim' },
			{ 'nvim-lua/plenary.nvim' },
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				run = 'make',
				disable = _G.is_windows(),
			},
			{
				'nvim-telescope/telescope-frecency.nvim',
				requires = { 'tami5/sqlite.lua' },
				disable = _G.is_windows(),
			},
		},
		wants = { 'which-key.nvim' },
		config = run,
	})
end
