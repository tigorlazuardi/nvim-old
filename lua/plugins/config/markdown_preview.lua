return function(use)
	use({ 'davidgranstrom/nvim-markdown-preview', ft = 'markdown' })
	use({
		'euclio/vim-markdown-composer',
		run = 'cargo build --release',
		disable = vim.fn.has('wsl') == 1,
		config = function()
			if vim.fn.exepath('pandoc') ~= '' then
				vim.g.markdown_composer_external_renderer = 'pandoc -f markdown -t html'
			end
			-- vim.g.markdown_composer_autostart = 0
		end,
		ft = 'markdown',
	})
end
