return function(use)
	_G.theme_list = {}
	_G.load_random_theme = function()
		local theme_name = _G.theme_list[math.random(#_G.theme_list)]
		vim.cmd('colo ' .. theme_name)
	end
	vim.cmd([[command! RandomColor lua _G.load_random_theme()]])

	use({
		'catppuccin/nvim',
		as = 'catppuccin',
		setup = function()
			table.insert(_G.theme_list, 'catppuccin')
		end,
		config = function()
			require('catppuccin').setup({
				integrations = {
					lsp_trouble = true,
					which_key = true,
					indent_blankline = {
						enabled = true,
						colored_indent_levels = true,
					},
					dashboard = false,
					vim_sneak = true,
					bufferline = true,
					markdown = true,
				},
			})
			require('catppuccin').load()
		end,
	})
end
