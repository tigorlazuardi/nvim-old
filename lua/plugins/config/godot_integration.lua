return function(use)
	use({
		'habamax/vim-godot',
		ft = { 'gd', 'gdscript', 'gdscript3' },
		cond = function()
			return vim.fn.exepath('godot') ~= ''
		end,
	})
end
