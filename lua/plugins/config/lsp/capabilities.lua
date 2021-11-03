local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = { 'documentation', 'detail', 'additionalTextEdits' },
}

local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if ok then
	cmp_nvim_lsp.update_capabilities(capabilities)
end

local lsp_status_present, lsp_status = pcall(require, 'lsp-status')
if lsp_status_present then
	capabilities = vim.tbl_extend('keep', capabilities, lsp_status.capabilities)
end

return capabilities
