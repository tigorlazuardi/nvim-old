---@return boolean
vim.g.is_windows = vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1

-- Set to false if godot is installed but you don't plan to use neovim
vim.g.use_godot_lsp = true

---@return string
---@param str string
function _G.t(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end
