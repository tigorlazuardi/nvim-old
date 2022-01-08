return function(use)
	use({
		'anuvyklack/pretty-fold.nvim',
		config = function()
			require('pretty-fold').setup({})
			-- require('pretty-fold.preview').setup_keybinding()
			--
			-- vim.cmd([[
			-- 	augroup pretty_fold_custom
			-- 		autocmd!
			-- 		autocmd CursorHold * lua require('pretty-fold.preview').show_preview()
			-- 	augroup end
			-- ]])
		end,
	})
end
