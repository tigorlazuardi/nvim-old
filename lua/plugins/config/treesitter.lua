local function run()
	require('nvim-treesitter.configs').setup({
		ensure_installed = 'all',
		context_commentstring = { enable = true },
		highlight = { enable = true, additional_vim_regex_highlighting = false },
		-- indent = { enable = false, disable = { 'yaml', 'dart' } },
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
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = '<cr>',
				scope_incremental = '<TAB>',
				node_incremental = '<cr>',
				node_decremental = '<s-cr>',
			},
		},
		rainbow = {
			enable = not vim.g.is_windows,
			extended_mode = true,
		},
		endwise = {
			enable = true,
		},
		playground = {
			enable = true,
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

	-- require('hlargs').setup()
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
			'p00f/nvim-ts-rainbow',
			'lewis6991/spellsitter.nvim',
			-- 'romgrk/nvim-treesitter-context',
			'windwp/nvim-ts-autotag',
			'RRethy/nvim-treesitter-endwise',
			'nvim-treesitter/playground',
		},
		config = run,
	})
end
