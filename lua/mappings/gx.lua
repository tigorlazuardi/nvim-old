local opts = { silent = true, noremap = true }

local remap = vim.api.nvim_set_keymap

-- remap gx to open browser url
if not _G.is_windows() then
	remap('n', 'gx', '<Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>', opts)
else
	remap('n', 'gx', '<Cmd>lua print("Error: gx is not supported on this OS!")<CR>', opts)
end
