return function(use)
	use({
		'akinsho/nvim-bufferline.lua',
		requires = 'kyazdani42/nvim-web-devicons',
		config = function()
			require('bufferline').setup({
				custom_filter = function(bufnr)
					if vim.bo[bufnr].filetype == 'dashboard' then
						return true
					end
				end,
				diagnostics = 'nvim_lsp',
			})
		end,
	})
end
