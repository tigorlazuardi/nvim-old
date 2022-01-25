local function run()
	require('nvim-treesitter.configs').setup({
		context_commentstring = { enable = true },
		highlight = { enable = true },
		indent = { enable = false, disable = { 'yaml' } },
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
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					[')'] = '@function.outer',
					[']m'] = '@class.outer',
				},
				goto_next_end = {
					[']]'] = '@function.outer',
					[']M'] = '@class.outer',
				},
				goto_previous_start = {
					['[['] = '@function.outer',
					['[m'] = '@class.outer',
				},
				goto_previous_end = {
					['('] = '@function.outer',
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
		rainbow = {
			enable = true,
			extended_mode = true,
		},
	})

	require('spellsitter').setup({
		hl = 'SpellBad',
		captures = { 'comment' }, -- set to {} to spellcheck everything
	})
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
	require('neogen').setup({
		enabled = true,
		langages = {
			lua = {
				template = {
					annotation_convention = 'emmylua',
				},
			},
		},
	})

	require('which-key').register({
		['<leader>a'] = {
			name = 'annonate',
			f = { [[<cmd>lua require('neogen').generate({type = "func"})<cr>]], 'Annonate Current Function' },
			F = { [[<cmd>lua require('neogen').generate({type = "file"})<cr>]], 'Annonate Current File' },
			c = { [[<cmd>lua require('neogen').generate({type = "class"})<cr>]], 'Annonate Current Class' },
			t = { [[<cmd>lua require('neogen').generate({type = "type"})<cr>]], 'Annonate Current Type' },
		},
	})

	vim.o.foldlevelstart = 1
	vim.o.foldmethod = 'expr'
	vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
end

return function(use)
	use({
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		requires = {
			'nvim-treesitter/nvim-treesitter-textobjects',
			'nvim-treesitter/playground',
			'p00f/nvim-ts-rainbow',
			'lewis6991/spellsitter.nvim',
			'romgrk/nvim-treesitter-context',
			'windwp/nvim-ts-autotag',
			'danymat/neogen',
		},
		config = run,
	})
end
