return function(use)
	use({
		'lukas-reineke/indent-blankline.nvim',
		setup = function()
			vim.g.indent_blankline_filetype_exclude = { 'dashboard', 'NvimTree', 'peek', 'packer', 'CHADTree' }
		end,
	})
end
