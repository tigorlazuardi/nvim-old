return function(use)
	use({
		'kana/vim-textobj-user',
		event = 'VimEnter',
		config = function()
			local prequire = require('personal.utils.prequire')
			local packer = prequire('packer')
			if not packer then
				return
			end
			packer.loader('vim-textobj-line')
			packer.loader('vim-textobj-xmlattr')
			packer.loader('vim-textobj-parameter')
			packer.loader('vim-textobj-variable-segment')
			packer.loader('vim-textobj-entire')
		end,
	}) -- Base dependencies
	use({ 'sgur/vim-textobj-parameter' }) -- argument select. a motion key
	use({ 'whatyouhide/vim-textobj-xmlattr' }) -- xml/html property select. x motion key
	use({ 'Julian/vim-textobj-variable-segment' }) -- camelcase & snakecase select. v motion key
	use({ 'kana/vim-textobj-line' }) -- select line. l motion key
	use({ 'kana/vim-textobj-entire' })
end
