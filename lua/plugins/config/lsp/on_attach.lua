---On attach lsp callback.
---Requires lsp-config, which-key, lsp_signature and telescope
---@param client any
---@param bufnr number
return function(client, bufnr)
	local wk_option = { buffer = bufnr }
	require('lsp_signature').on_attach({
		bind = true,
		handler_opts = {
			border = 'rounded',
		},
		floating_window = true,
		hint_prefix = 'hint: ',
		floating_window_above_cur_line = true,
		toggle_key = '<m-x>',
	}, bufnr)

	local lsp_mappings = require('personal.lsp.mappings')
	local wk = require('which-key')
	wk.register({
		K = {
			function()
				local open_hover = require('plugins.config.lsp.open_hover')
				open_hover.open_hover()
			end,
			'(LSP) Symbol Definition / Documentation',
		},
		['<leader>w'] = {
			name = 'lsp_workspace',
			a = { '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', 'Add Folder to Workspace' },
			r = { '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', 'Remove Folder from Workspace' },
			l = {
				'<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
				'List Registered Folders in Workspace',
			},
		},
		gi = {
			function()
				lsp_mappings.implementations()
			end,
			'(LSP) Go to Symbol Implementations',
		},
		gs = {
			function()
				lsp_mappings.document_symbols()
			end,
			'(LSP) List Symbols (Current Buffer)',
		},
		gS = {
			function()
				lsp_mappings.live_workspace_symbols()
			end,
			'(LSP) Search Workspace Symbols',
		},
		gO = {
			function()
				lsp_mappings.type_definitions()
			end,
			'(LSP) Go to Type Definition',
		},
		gn = {
			name = '+diagnostic',
			n = {
				'<cmd>lua vim.diagnostic.open_float(nil, {border = "single"})<CR>',
				'(LSP) Show Line Diagnostic',
			},
			N = {
				function()
					lsp_mappings.workspace_diagnostics()
				end,
				'(LSP) Show Workspace Diagnostics',
			},
			p = {
				'<cmd>lua vim.diagnostic.goto_prev({ float = false })<CR>',
				'(Diagnostics) Go to Previous Diagnostic',
			},
			e = {
				'<cmd>lua vim.diagnostic.goto_next({ float = false })<CR>',
				'(Diagnostics) Go to Next Diagnostic',
			},
		},
		ga = {
			'<cmd>lua vim.lsp.buf.code_action()<cr>',
			'(LSP) Code Actions',
		},
		gr = {
			function()
				lsp_mappings.references()
			end,
			'(LSP) Symbol References',
		},
		gR = {
			function()
				lsp_mappings.incoming_calls()
			end,
			'(LSP) Incoming Calls',
		},
		gd = {
			function()
				lsp_mappings.definitions()
			end,
			'(LSP) Go to Symbol Definition',
		},
		gD = {
			function()
				vim.cmd('vsplit')
				vim.schedule(vim.lsp.buf.definition)
			end,
			'(LSP) Go To Definitions (V-Split)',
		},
		['<F2>'] = { '<cmd>lua vim.lsp.buf.rename()<CR>', '(LSP) Rename Symbol' },
	}, wk_option)

	if client.server_capabilities.documentHighlightProvider then
		vim.cmd([[
			autocmd CursorHold <buffer> silent! lua vim.lsp.buf.document_highlight()
			autocmd CursorMoved <buffer> silent! lua vim.lsp.buf.clear_references()
	    ]])
	end

	local ok, lsp_status = pcall(require, 'lsp-status')
	if ok then
		lsp_status.on_attach(client)
	end

	vim.cmd([[au CursorHold <buffer> lua require('plugins.config.lsp.open_hover').open_diagnostic()]])
	vim.cmd([[au CursorMoved <buffer> lua require('plugins.config.lsp.open_hover').clean_diagnostic()]])
	vim.cmd([[au CursorMoved <buffer> lua require('plugins.config.lsp.open_hover').clean_hover()]])

	local signs = { Error = ' ', Warn = ' ', Hint = ' ', Information = ' ' }

	for type, icon in pairs(signs) do
		local hl = 'DiagnosticSign' .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
	end
end
