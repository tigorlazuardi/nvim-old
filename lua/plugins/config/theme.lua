return function(use)
	_G.theme_list = {}
	_G.load_random_theme = function()
		local theme_name = _G.theme_list[math.random(#_G.theme_list)]
		vim.cmd('colo ' .. theme_name)
	end
	vim.cmd([[au VimEnter * lua _G.load_random_theme()]])
	vim.cmd([[command! RandomColor lua _G.load_random_theme()]])

	use({
		'sainnhe/sonokai',
		opt = false,
		setup = function()
			table.insert(_G.theme_list, 'sonokai')
		end,
	})
	use({
		'folke/tokyonight.nvim',
		opt = false,
		setup = function()
			vim.g.tokyonight_italic_functions = true
			table.insert(_G.theme_list, 'tokyonight')
		end,
	})

	use({
		'rafamadriz/neon',
		opt = false,
		setup = function()
			table.insert(_G.theme_list, 'neon')
		end,
	})

	use({
		'marko-cerovac/material.nvim',
		opt = false,
		setup = function()
			vim.g.material_style = 'darker'
			table.insert(_G.theme_list, 'material')
		end,
	})

	use({
		'mhartington/oceanic-next',
		opt = false,
		setup = function()
			table.insert(_G.theme_list, 'OceanicNext')
		end,
	})

	use({
		'glepnir/zephyr-nvim',
		opt = false,
		setup = function()
			table.insert(_G.theme_list, 'zephyr')
		end,
	})
end
