local function run()
	local prequire = require('personal.utils.prequire')
	local packer = prequire('packer')
	if not packer then
		return
	end
	packer.loader('plenary.nvim')
	packer.loader('telescope-fzf-native.nvim')
	packer.loader('telescope-file-browser.nvim')
	local wk = require('which-key')
	wk.register({
		['<leader>f'] = {
			name = '+find',
			f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", 'Find File' },
			g = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", 'Live Grep (Word Search)' },
			b = { "<cmd>lua require('telescope.builtin').buffers()<cr>", 'Find Buffer' },
			h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", 'List Help Tags' },
			c = {
				function()
					local pickers = require('telescope.pickers')
					local finders = require('telescope.finders')
					local conf = require('telescope.config').values
					local actions = require('telescope.actions')
					local actions_set = require('telescope.actions.set')
					local state = require('telescope.actions.state')
					local Path = require('plenary.path')
					local os_sep = Path.path.sep

					pickers.new({}, {
						prompt_title = 'CD Dir',
						finder = finders.new_oneshot_job({ 'fd', '-t', 'd', '-H' }, {
							cwd = vim.fn.getcwd(),
						}),
						sorter = conf.generic_sorter({}),
						previewer = conf.file_previewer({}),
						attach_mappings = function(prompt_bufnr, _map)
							local test = function()
								return state.get_selected_entry().path:sub(-1) == os_sep
							end
							actions_set.select:replace_if(test, function()
								local selected = state.get_selected_entry(prompt_bufnr)
								actions.close(prompt_bufnr)
								if selected == nil then
									return
								end
								local result = vim.fn.chdir(selected.value)
								if result == '' then
									error('failed to cd to ' .. selected.value, vim.diagnostic.severity.E)
								end
							end)
							return true
						end,
					}):find()
				end,
				'Change Directory',
			},
		},
	})

	local actions = require('telescope.actions')
	local telescope_mappings = {
		i = { ['<esc>'] = actions.close },
	}

	pcall(packer.loader, 'trouble.nvim')
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
	use({
		'nvim-telescope/telescope.nvim',
		wants = { 'which-key.nvim' },
		event = 'VimEnter',
		config = run,
	})
	use({
		'nvim-telescope/telescope-file-browser.nvim',
		config = function()
			require('telescope').load_extension('file_browser')
		end,
	})
	use({
		'nvim-telescope/telescope-fzf-native.nvim',
		run = 'make',
		wants = { 'telescope.nvim' },
		after = { 'telescope.nvim' },
		event = 'VimEnter',
		cond = function()
			return not vim.g.is_windows
		end,
		config = function()
			local telescope = require('telescope')
			telescope.load_extension('fzf')
		end,
	})
end
