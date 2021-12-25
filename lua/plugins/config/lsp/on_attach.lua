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
			name = '+diagnostic',
			n = {
				'<cmd>lua vim.diagnostic.open_float(nil, {border = "single"})<CR>',
				'(LSP) Show Line Diagnostic',
			},
			N = {
				"<cmd>lua require('telescope.builtin').diagnostics()<cr>",
				'(LSP) Show Workspace Diagnostics',
			},
			p = {
				'<cmd>lua vim.diagnostic.goto_prev({ popup_opts = { border = "single" }})<CR>',
				'(Diagnostics) Go to Previous Diagnostic',
			},
			e = {
				'<cmd>lua vim.diagnostic.goto_next({ popup_opts = { border = "single" }})<CR>',
				'(Diagnostics) Go to Next Diagnostic',
			},
		},
		ga = {
			'<cmd>lua vim.lsp.buf.code_action()<cr>',
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
			autocmd CursorHold <buffer> silent! lua vim.lsp.buf.document_highlight()
			autocmd CursorMoved <buffer> silent! lua vim.lsp.buf.clear_references()
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

	if packer_plugins['symbols-outline.nvim'] and packer_plugins['symbols-outline.nvim'].loaded then
		wk.register({
			gs = { '<cmd>SymbolsOutline<cr>', 'Symbol Outline' },
		}, wk_option)
	end

	local have_saga, _ = pcall(require, 'lspsaga')
	if have_saga then
		wk.register({
			K = { [[<cmd>lua require('lspsaga.hover').render_hover_doc()<cr>]], 'Hover Documentation' },
			['<c-d>'] = {
				[[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>]],
				'Scroll Window or Documentation Down',
			},
			['<c-u>'] = {
				[[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>]],
				'Scroll Window or Documentation Up',
			},
			['<F2>'] = {
				[[<cmd>lua require('lspsaga.rename').rename()<CR>]],
				'Rename Symbol',
			},
			gd = {
				[[<cmd>lua require('lspsaga.provider').preview_definition()<cr>]],
				'Preview Definition',
			},
			gD = {
				"<cmd>lua require('telescope.builtin').lsp_definitions()<cr>",
				'(LSP) Go to Symbol Definition',
			},
			gn = {
				name = '+diagnostic',
				n = {
					[[<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>]],
					'Diagnostic (Current Line)',
				},
				p = {
					[[<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>]],
					'Diagnostic Previous',
				},
				e = {
					[[<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>]],
					'Diagnostic Next',
				},
			},
		}, wk_option)
	end
end
