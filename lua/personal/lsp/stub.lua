local opts = {
	title = 'Lsp Mappings',
	replace = 1024 * 21,
}

local M = {
	implementations = function()
		vim.notify('no plugins support for go to implementations', 'error', opts)
	end,
	document_symbols = function()
		vim.notify('no plugins support for go to document symbols', 'error', opts)
	end,
	live_workspace_symbols = function()
		vim.notify('no plugins support for go to live workspace symbols', 'error', opts)
	end,
	workspace_symbols = function()
		vim.notify('no plugins support for go to workspace symbols', 'error', opts)
	end,
	document_diagnostics = function()
		vim.notify('no plugins support for document diagnostics', 'error', opts)
	end,
	workspace_diagnostics = function()
		vim.notify('no plugins support for workspace diagnostics', 'error', opts)
	end,
	references = function()
		vim.notify('no plugins support for go to references', 'error', opts)
	end,
	incoming_calls = function()
		vim.notify('no plugins support for go to incoming calls', 'error', opts)
	end,
	definitions = function()
		vim.notify('no plugins support for go to definitions', 'error', opts)
	end,
	type_definitions = function()
		vim.notify('no plugins support for go to type definitions', 'error', opts)
	end,
}

return M
