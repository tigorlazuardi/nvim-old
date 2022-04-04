return function(use)
	use({ 'davidgranstrom/nvim-markdown-preview', ft = 'markdown' })
	use({
		'euclio/vim-markdown-composer',
		run = 'cargo build --release',
		disable = vim.fn.has('wsl') == 1,
		config = function()
			vim.g.markdown_composer_autostart = 0
		end,
		ft = 'markdown',
	})
end
