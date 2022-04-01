return function(use)
	use({
		'machakann/vim-sandwich',
		setup = function()
			vim.g.sandwich_no_default_key_mappings = 1
		end,
		config = function()
			vim.cmd([[
				" add
				silent! nmap <unique> <leader>qa <Plug>(sandwich-add)
				silent! xmap <unique> <leader>qa <Plug>(sandwich-add)
				silent! omap <unique> <leader>qa <Plug>(sandwich-add)

				" delete
				silent! nmap <unique> <leader>qd <Plug>(sandwich-delete)
				silent! xmap <unique> <leader>qd <Plug>(sandwich-delete)
				silent! nmap <unique> <leader>qdb <Plug>(sandwich-delete-auto)

				" replace
				silent! nmap <unique> <leader>qr <Plug>(sandwich-replace)
				silent! xmap <unique> <leader>qr <Plug>(sandwich-replace)
				silent! nmap <unique> <leader>qrb <Plug>(sandwich-replace-auto)
			]])
			vim.cmd([[
				" auto
				silent! omap <unique> ib <Plug>(textobj-sandwich-auto-i)
				silent! xmap <unique> ib <Plug>(textobj-sandwich-auto-i)
				silent! omap <unique> ab <Plug>(textobj-sandwich-auto-a)
				silent! xmap <unique> ab <Plug>(textobj-sandwich-auto-a)

				" query
				silent! omap <unique> is <Plug>(textobj-sandwich-query-i)
				silent! xmap <unique> is <Plug>(textobj-sandwich-query-i)
				silent! omap <unique> as <Plug>(textobj-sandwich-query-a)
				silent! xmap <unique> as <Plug>(textobj-sandwich-query-a)
			]])
		end,
	})
end
