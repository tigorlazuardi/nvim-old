return function()
	print('masuuuk')
	local prequire = require('personal.utils.prequire')

	local calltree = prequire('calltree')
	if not calltree then
		return
	end
	local wk = prequire('which-key')

	if not wk then
		return
	end

	local wk_option = { bufnr = 0 }

	wk.register({
		K = { '<cmd>CTDetails<cr>', 'Show Details' },
		['<cr>'] = { '<cmd>CTJump<cr>', 'Jump to Symbol' },
		['?'] = { [[<cmd>lua require('calltree.ui').help(true)<cr>]], 'Show Help' },
		['??'] = { [[<cmd>lua require('calltree.ui').help(true)<cr>]], 'Show Help' },
		l = { '<cmd>CTExpand<cr>', 'Expand Tree' },
		h = { '<cmd>CTCollapse<cr>', 'Collapse Tree' },
		f = { '<cmd>CTFocus<cr>', 'Focus Symbol' },
		i = { '<cmd>CTHover<cr>', 'Hover Symbol' },
		q = { '<cmd>CTClose<cr>', 'Close Calltree' },
		qq = { '<cmd>CTClose<cr>', 'Close Calltree' },
	}, wk_option)
end
