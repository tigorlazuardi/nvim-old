---On attach lsp callback.
---Requires lsp-config, which-key, lsp_signature and telescope
---@param client any
---@param bufnr number
return function(client, bufnr)
	local wk_option = { buffer = bufnr }
	require('lsp_signature').on_attach(client, bufnr)

	local wk = require('which-key')
	wk.register({
		['K'] = { '<Cmd>lua vim.lsp.buf.hover()<CR>', '(LSP) Symbol Definition / Documentation' },
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
			"<cmd>lua require('telescope.builtin').lsp_implementations()<cr>",
			'(LSP) Go to Symbol Implementations',
		},
		gs = {
			"<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>",
			'(LSP) List Symbols (Current Buffer)',
		},
		gS = {
			"<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>",
			'(LSP) Search Workspace Symbols',
		},
		gn = {
			'<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',
			'(LSP) Show Line Diagnostic',
		},
		gN = {
			"<cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>",
			'(LSP) Show Workspace Diagnostics',
		},
		gnp = { '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', '(Diagnostics) Go to Previous Diagnostic' },
		gnn = { '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', '(Diagnostics) Go to Next Diagnostic' },
		ga = {
			'<cmd>CodeActionMenu<cr>',
			'(LSP) Code Actions',
		},
		gr = {
			"<cmd>lua require('telescope.builtin').lsp_references()<cr>",
			'(LSP) Symbol References',
		},
		gd = {
			"<cmd>lua require('telescope.builtin').lsp_definitions()<cr>",
			'(LSP) Go to Symbol Definition',
		},
		gD = {
			function()
				vim.cmd('vsplit')
				vim.lsp.buf.definition()
			end,
			'(LSP) Go To Definitions (V-Split)',
		},
		['<F2>'] = { '<cmd>lua vim.lsp.buf.rename()<CR>', '(LSP) Rename Symbol' },
	}, wk_option)

	if client.resolved_capabilities.document_highlight then
		vim.cmd([[
            augroup lsp_document_highlight
                autocmd!
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]])
	end

	local ok, lsp_status = pcall(require, 'lsp-status')
	if ok then
		lsp_status.on_attach(client)
	end

	local signs = { Error = ' ', Warn = ' ', Hint = ' ', Information = ' ' }

	for type, icon in pairs(signs) do
		local hl = 'DiagnosticSign' .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
	end
end
