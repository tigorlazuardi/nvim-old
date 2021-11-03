---@return boolean
function _G.is_windows()
	return vim.fn.has('win32') ~= 0 or vim.fn.has('win64') ~= 0
end

---@return string
---@param str string
function _G.t(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end
