return function(use)
	_G.theme_list = {}
	_G.loaded_theme = ''
	_G.load_random_theme = function()
		local theme_name = _G.theme_list[math.random(#_G.theme_list)]
		_G.loaded_theme = theme_name
		vim.cmd('colo ' .. theme_name)
	end
	_G.load_random_theme_delayed = function()
		vim.defer_fn(function()
			_G.load_random_theme()
		end, 100)
	end
	-- vim.cmd([[au DirChanged * lua _G.load_random_theme_delayed()]])
	vim.cmd([[command! RandomColor lua _G.load_random_theme()]])

	use({
		'sainnhe/sonokai',
		setup = function()
			table.insert(_G.theme_list, 'sonokai')
		end,
	})
	use({
		'folke/tokyonight.nvim',
		setup = function()
			vim.g.tokyonight_italic_functions = true
			table.insert(_G.theme_list, 'tokyonight')
		end,
	})

	use({
		'rafamadriz/neon',
		setup = function()
			table.insert(_G.theme_list, 'neon')
		end,
	})

	use({
		'marko-cerovac/material.nvim',
		setup = function()
			vim.g.material_style = 'darker'
			table.insert(_G.theme_list, 'material')
		end,
	})

	use({
		'mhartington/oceanic-next',
		setup = function()
			table.insert(_G.theme_list, 'OceanicNext')
		end,
	})

	use({
		'glepnir/zephyr-nvim',
		setup = function()
			table.insert(_G.theme_list, 'zephyr')
		end,
	})

	use({
		'catppuccin/nvim',
		as = 'catppuccin',
		setup = function()
			table.insert(_G.theme_list, 'catppuccin')
		end,
		config = function()
			vim.cmd([[colo catppuccin]])
			vim.defer_fn(function()
				vim.cmd([[colo catppuccin]])
			end, 100)
		end,
	})
end
