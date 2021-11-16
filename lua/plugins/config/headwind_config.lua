return function(use)
	_G.headwind_sort = function()
		local present, headwind = pcall(require, 'headwind')
		if not present then
			return
		end

		if vim.fn.filereadable(vim.fn.getcwd() .. '/tailwind.config.js') == 1 then
			headwind.buf_sort_tailwind_classes()
		end
	end

	use({
		'steelsojka/headwind.nvim',
		wants = { 'which-key.nvim' },
		config = function()
			require('headwind').setup({
				-- it's annoying that this does not run silently
				run_on_save = false,
			})

			require('which-key').register({
				q = {
					name = 'quick',
					c = {
						[[<cmd>silent! lua require('headwind').buf_sort_tailwind_classes()<cr>]],
						'Sort Tailwind Classes',
					},
				},
			})

			vim.cmd([[
				augroup headwind_silent_autosave
					au!
					au BufWritePre *.tsx,*.jsx,*.html,*.css silent! lua _G.headwind_sort()
				augroup end
			]])
		end,
		ft = { 'typescriptreact', 'javascriptreact', 'jsx', 'tsx', 'html', 'css' },
	})
end
