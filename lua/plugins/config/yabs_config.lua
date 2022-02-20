return function(use)
	use({
		'pianocomposer321/yabs.nvim',
		requires = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('yabs'):setup({})
			require('telescope').load_extension('yabs')
		end,
	})
end
