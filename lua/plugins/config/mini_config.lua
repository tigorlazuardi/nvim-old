return function(use)
	use({
		'echasnovski/mini.nvim',
		config = function()
			local blacklist = { 'dashboard', 'NvimTree', 'peek', 'packer', 'CHADTree', 'alpha' }
			require('mini.indentscope').setup({})
			for _, filetype in ipairs(blacklist) do
				vim.cmd(
					string.format(
						'au filetype %s lua vim.b.miniindentscope_disable = true; MiniIndentscope.undraw()',
						filetype
					)
				)
			end
		end,
	})
end
