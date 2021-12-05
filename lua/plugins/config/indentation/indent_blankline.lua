return function(use)
	vim.g.indent_blankline_filetype_exclude = { 'dashboard', 'NvimTree', 'peek', 'packer' }
	use({ 'lukas-reineke/indent-blankline.nvim', event = 'BufEnter' })
end
