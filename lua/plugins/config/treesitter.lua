local function run()
	local load = require('packer').loader
	load('playground')
	load('spellsitter.nvim')
	load('nvim-treesitter-context')
	load('nvim-ts-autotag')
	load('nvim-treesitter-textobjects')
	require('nvim-treesitter.configs').setup({
		context_commentstring = { enable = true },
		highlight = { enable = true },
		indent = { enable = true, disable = { 'python', 'yaml' } },
		autopairs = { enable = true },
		textobjects = {
			select = {
				enable = true,
				-- Automatically jump forward to textobj, similar to targets.vim
				lookahead = true,
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					['af'] = '@function.outer',
					['if'] = '@function.inner',
					['ac'] = '@class.outer',
					['ic'] = '@class.inner',
				},
			},
			swap = {
				enable = false,
				swap_next = { ['<leader>a'] = '@parameter.inner' },
				swap_previous = { ['<leader>A'] = '@parameter.inner' },
			},
			move = {
				enable = false,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					[']]'] = '@function.outer',
					[']m'] = '@class.outer',
				},
				goto_next_end = {
					[']['] = '@function.outer',
					[']M'] = '@class.outer',
				},
				goto_previous_start = {
					['[['] = '@function.outer',
					['[m'] = '@class.outer',
				},
				goto_previous_end = {
					['[]'] = '@function.outer',
					['[m'] = '@class.outer',
				},
			},
		},
		playground = {
			enable = true,
			disable = {},
			updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
			persist_queries = false, -- Whether the query persists across vim sessions
			keybindings = {
				toggle_query_editor = 'o',
				toggle_hl_groups = 'i',
				toggle_injected_languages = 't',
				toggle_anonymous_nodes = 'a',
				toggle_language_display = 'I',
				focus_language = 'f',
				unfocus_language = 'F',
				update = 'R',
				goto_node = '<cr>',
				show_help = '?',
			},
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = '<CR>',
				scope_incremental = '<CR>',
				node_incremental = '<TAB>',
				node_decremental = '<S-TAB>',
			},
		},
	})
end

local function spell_sitter()
	require('spellsitter').setup({
		hl = 'SpellBad',
		captures = { 'comment' }, -- set to {} to spellcheck everything
	})
end

return function(use)
	use({
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = run,
		opt = false,
	})
	use('nvim-treesitter/nvim-treesitter-textobjects')
	use({
		'nvim-treesitter/playground',
	})
	use({
		'lewis6991/spellsitter.nvim',
		config = spell_sitter,
	})
	use({
		'romgrk/nvim-treesitter-context',
		config = function()
			require('treesitter-context').setup({
				enable = true,
			})
		end,
	})
	use({
		'windwp/nvim-ts-autotag',
		config = function()
			require('nvim-ts-autotag').setup({
				filetypes = {
					'html',
					'xml',
					'javascript',
					'javascriptreact',
					'typescriptreact',
					'svelte',
					'vue',
				},
			})
		end,
	})
end
