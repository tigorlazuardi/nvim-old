return function(use)
	vim.g.registers_delay = 0
	use({ 'tversteeg/registers.nvim', event = 'VimEnter' })
end
