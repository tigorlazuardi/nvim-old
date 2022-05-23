local function nmap(lhs, rhs, opts)
	opts = opts or {}
	vim.keymap.set('n', lhs, rhs, opts)
end

local ok_fzf, fzf_lua = pcall(require, 'fzf-lua')
if ok_fzf then
	nmap('<c-f>', function()
		fzf_lua.files()
	end, { desc = 'Files Picker' })
	nmap('<c-b>', function()
		fzf_lua.buffers()
	end, { desc = 'Buffer Picker' })
	nmap('<c-t>', function()
		fzf_lua.live_grep_native()
	end, 'Live Grep (Workspace)')
	return
end

local ok_telescope = pcall(require, 'telescope')
if ok_telescope then
	vim.keymap.set('n', '<c-t>', '<cmd>Telescope live_grep<cr>', { desc = 'Live Grep (Word Search)' })
	vim.keymap.set('n', '<c-b>', '<cmd>Telescope buffers<cr>', { desc = 'Buffer Picker' })
	vim.keymap.set('n', '<c-f>', '<cmd>Telescope find_files hidden=true<cr>', { desc = 'File Picker' })
	return
end
