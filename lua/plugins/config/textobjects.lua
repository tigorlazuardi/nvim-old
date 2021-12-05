return function(use)
	use({ 'kana/vim-textobj-user', event = 'BufEnter' }) -- Base dependencies
	use({ 'sgur/vim-textobj-parameter', event = 'BufEnter' }) -- argument select. a motion key
	use({ 'whatyouhide/vim-textobj-xmlattr', event = 'BufEnter' }) -- xml/html property select. x motion key
	use({ 'Julian/vim-textobj-variable-segment', event = 'BufEnter' }) -- camelcase & snakecase select. v motion key
	use({ 'kana/vim-textobj-line', event = 'BufEnter' }) -- select line. l motion key
	use({ 'kana/vim-textobj-entire', event = 'BufEnter' })
end
