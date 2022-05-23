if pcall(require, 'fzf-lua') then
	vim.keymap.set('n', '<c-f>', '<cmd>FzfLua files<cr>', { desc = 'Files Picker' })
	vim.keymap.set('n', '<c-b>', '<cmd>FzfLua buffers<cr>', { desc = 'Buffer Picker' })
	vim.keymap.set('n', '<c-t>', '<cmd>FzfLua live_grep_native<cr>', { desc = 'Live Grep (Workspace)' })
	return
end

if pcall(require, 'telescope') then
	vim.keymap.set('n', '<c-t>', '<cmd>Telescope live_grep<cr>', { desc = 'Live Grep (Word Search)' })
	vim.keymap.set('n', '<c-b>', '<cmd>Telescope buffers<cr>', { desc = 'Buffer Picker' })
	vim.keymap.set('n', '<c-f>', '<cmd>Telescope find_files hidden=true<cr>', { desc = 'File Picker' })
	return
end
