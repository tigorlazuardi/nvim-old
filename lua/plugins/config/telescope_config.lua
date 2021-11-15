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
end

return function(use)
	use({ 'nvim-lua/plenary.nvim' })
	use({ 'nvim-lua/popup.nvim' })
	use({
		'nvim-telescope/telescope.nvim',
		wants = { 'which-key.nvim' },
		config = run,
	})
	use({
		'nvim-telescope/telescope-fzf-native.nvim',
		run = 'make',
		wants = { 'telescope.nvim' },
		after = { 'telescope.nvim' },
		cond = function()
			return not vim.g.is_windows
		end,
		config = function()
			local telescope = require('telescope')
			telescope.load_extension('fzf')
		end,
	})
	use({
		'nvim-telescope/telescope-frecency.nvim',
		wants = { 'telescope.nvim' },
		after = { 'telescope.nvim' },
		requires = { 'tami5/sqlite.lua' },
		cond = function()
			return not vim.g.is_windows
		end,
		config = function()
			local telescope = require('telescope')
			telescope.load_extension('frecency')
		end,
	})
end
