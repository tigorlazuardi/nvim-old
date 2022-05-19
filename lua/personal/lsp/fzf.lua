local fzf_lua = require('fzf-lua')

local M = {
	implementations = function()
		fzf_lua.lsp_implementations()
	end,
	document_symbols = function()
		fzf_lua.lsp_document_symbols()
	end,
	live_workspace_symbols = function()
		fzf_lua.lsp_live_workspace_symbols()
	end,
	workspace_symbols = function()
		fzf_lua.lsp_workspace_symbols()
	end,
	document_diagnostics = function()
		fzf_lua.lsp_document_diagnostics()
	end,
	workspace_diagnostics = function()
		fzf_lua.lsp_workspace_diagnostics()
	end,
	references = function()
		fzf_lua.lsp_references()
	end,
	incoming_calls = function()
		fzf_lua.lsp_incoming_calls()
	end,
	definitions = function()
		fzf_lua.lsp_definitions()
	end,
	type_definitions = function()
		fzf_lua.lsp_typedefs()
	end,
}

return M
