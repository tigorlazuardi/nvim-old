---@return boolean
vim.g.is_windows = vim.fn.has('win32') or vim.fn.has('win64')
vim.g.not_vscode = vim.g.vscode ~= 1

---@return string
---@param str string
function _G.t(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end
