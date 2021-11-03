
return function(use)
	vim.g.yoinkSyncNumberedRegisters = 1
	-- vim.g.yoinkSavePersistently = 1
	vim.g.yoinkIncludeDeleteOperations = 1
	vim.g.registers_delay = 0
	use({ 'tversteeg/registers.nvim', requires = { 'svermeulen/vim-yoink', } })
end
