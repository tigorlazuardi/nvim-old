return function(use)
	use("kana/vim-textobj-user") -- Base dependencies
	use("sgur/vim-textobj-parameter") -- argument select. a motion key
	use("whatyouhide/vim-textobj-xmlattr") -- xml/html property select. x motion key
	use("Julian/vim-textobj-variable-segment") -- camelcase & snakecase select. v motion key
	use("kana/vim-textobj-line") -- select line. l motion key
	use("kana/vim-textobj-entire")
end
