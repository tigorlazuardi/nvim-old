local function config()
	require('spectre').setup()
	local wk = require('which-key')

	wk.register({
		r = { [[<cmd>lua require('spectre').open()<cr>]], 'Open Find and Replace' },
		w = { [[<cmd>lua require('spectre').open_visual({select_word = true})<cr>]], 'Open Find and Replace <cword>' },
		s = { [[<cmd>lua require('spectre').open_file_search()<cr>]], 'Open File Search' },
	}, {
		prefix = '<leader>f',
	})

	-- wk.register({
	-- 	['<leader>fr'] = { [[<cmd>lua require('spectre').open_visual()<cr>]], 'Open Find and Replace' },
	-- 	{ mode = 'v' },
	-- })
end

return function(use)
	use({
		'windwp/nvim-spectre',
		requires = { 'nvim-lua/plenary.nvim' },
		wants = { 'which-key.nvim' },
		config = config,
		event = 'VimEnter',
	})
end
