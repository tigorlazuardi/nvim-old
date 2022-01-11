local M = {}

M.hover_is_open = false
M.diagnostic_is_open = false
M.diagnostic_buffer = 17013

function M.open_hover()
	if M.diagnostic_is_open then
		vim.api.nvim_buf_delete(M.diagnostic_buffer, { force = true })
		M.diagnostic_is_open = false
	end
	M.hover_is_open = true
	vim.lsp.buf.hover()
end

function M.clean_hover()
	M.hover_is_open = false
end

function M.open_diagnostic()
	if M.hover_is_open or M.diagnostic_is_open then
		return
	end

	local bufnr, _win_id = vim.diagnostic.open_float({ scope = 'cursor', focus = 'false' })
	if bufnr then
		M.diagnostic_buffer = bufnr
		M.diagnostic_is_open = true
	end
end

function M.clean_diagnostic()
	M.diagnostic_is_open = false
end

return M
