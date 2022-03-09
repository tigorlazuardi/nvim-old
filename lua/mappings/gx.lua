local opts = { silent = true, noremap = true }

local remap = vim.api.nvim_set_keymap

-- remap gx to open browser url
if not vim.g.is_windows then
	remap('n', 'gx', '<Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>', opts)
else
	remap(
		'n',
		'gx',
		'<Cmd>lua vim.notify("gx shortcut is not supported", "error", {title = "Not Supported on this OS!"})<CR>',
		opts
	)
end
