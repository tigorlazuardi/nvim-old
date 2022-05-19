local telescope = require('telescope.builtin')

local M = {
	implementations = function()
		telescope.lsp_implementations()
	end,
	document_symbols = function()
		telescope.lsp_document_symbols()
	end,
	live_workspace_symbols = function()
		telescope.lsp_dynamic_workspace_symbols()
	end,
	workspace_symbols = function()
		telescope.lsp_workspace_symbols()
	end,
	document_diagnostics = function()
		telescope.diagnostics()
	end,
	workspace_diagnostics = function()
		telescope.diagnostics()
	end,
	references = function()
		telescope.lsp_references()
	end,
	incoming_calls = function()
		telescope.lsp_references()
	end,
	definitions = function()
		telescope.lsp_definitions()
	end,
	type_definitions = function()
		telescope.lsp_type_definitions()
	end,
}

return M
