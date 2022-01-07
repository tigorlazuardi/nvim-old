return function(use)
	use({
		'kdheepak/lazygit.nvim',
		setup = function()
			if vim.fn.has('nvim') == 1 and vim.fn.executable('nvr') == 1 then
				vim.fn.setenv('GIT_EDITOR', "nvr -cc split --remote-wait +'set bufhidden=wipe'")
			end
			vim.g.lazygit_floating_window_use_plenary = 1
		end,
		config = function()
			require('which-key').register({
				['<leader>z'] = { '<cmd>LazyGit<cr>', 'Lazy Git' },
			})
		end,
	})
end
