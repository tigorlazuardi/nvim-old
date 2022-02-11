return function(use)
	use({
		'lukas-reineke/indent-blankline.nvim',
		setup = function()
			vim.g.indent_blankline_filetype_exclude = { 'dashboard', 'NvimTree', 'peek', 'packer', 'CHADTree', 'alpha' }
		end,
		config = function()
			require('indent_blankline').setup({
				show_current_context = true,
				show_current_context_start = true,
				use_treesitter = true,
			})
		end,
	})
end
