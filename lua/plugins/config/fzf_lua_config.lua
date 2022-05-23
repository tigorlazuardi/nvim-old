return function(use)
	use({
		'ibhagwan/fzf-lua',
		requires = {
			-- optional for icon support
			{ 'kyazdani42/nvim-web-devicons' },
			{
				'junegunn/fzf',
				run = './install --bin',
				disable = vim.fn.exepath('sk') ~= '' or vim.fn.exepath('fzf') ~= '',
			},
		},
		disable = vim.g.is_windows,
		config = function()
			local fzf_lua = require('fzf-lua')

			fzf_lua.setup({
				fzf_bin = vim.fn.exepath('sk') ~= '' and 'sk' or 'fzf',
				winopts = {
					preview = {
						default = vim.fn.exepath('bat') ~= '' and 'bat' or 'builtin',
					},
				},
			})

			require('mappings.pickers')
		end,
	})
end
