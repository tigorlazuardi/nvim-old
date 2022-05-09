return function(use)
	use({
		'nathom/filetype.nvim',
		config = function()
			-- config opts: https://github.com/nathom/filetype.nvim#customization
			require('filetype').setup({
				overrides = {
					extensions = {
						mdpp = 'markdown',
					},
					literal = {
						['tsconfig.json'] = 'jsonc',
						['jsconfig.json'] = 'jsonc',
						['mods.txt'] = 'javascript', -- rpgmaker mods.txt
					},
					complex = {
						['.*vscode/launch.json'] = 'jsonc',
					},
				},
			})
		end,
	})
end
