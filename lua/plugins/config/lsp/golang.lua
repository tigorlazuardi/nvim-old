if vim.fn.exepath('gopls') ~= '' then
	function OrgImports(wait_ms)
		local params = vim.lsp.util.make_range_params()
		params.context = { only = { 'source.organizeImports' } }
		local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, wait_ms)
		for _, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					vim.lsp.util.apply_workspace_edit(r.edit)
				else
					pcall(vim.lsp.buf.execute_command, r.command)
				end
			end
		end
		vim.lsp.buf.formatting_sync({}, wait_ms)
	end

	local present, lspconfig = pcall(require, 'lspconfig')
	if not present then
		return
	end

	local configuration = {
		on_attach = function(client, bufnr)
			client.resolved_capabilities.document_formatting = true
			require('plugins.config.lsp.on_attach')(client, bufnr)
			vim.cmd([[
					autocmd BufWritePre <buffer> lua OrgImports(1000)
			]])
			local wk = require('which-key')

			wk.register({
				['<leader>g'] = {
					name = '+go',
					f = {
						function()
							OrgImports(1000)
						end,
						'Organize Imports',
					},
				},
			}, { buffer = bufnr })

			if packer_plugins['goimpl.nvim'] then
				wk.register({
					['<leader>gi'] = {
						function()
							require('telescope').extensions.goimpl.goimpl()
						end,
						'Generate Implementations',
					},
				}, { buffer = bufnr })
			end
		end,
		cmd = {
			'gopls',
		},
		root_dir = lspconfig.util.root_pattern('.git', 'go.mod', 'main.go'),
		settings = {
			gopls = {
				-- more settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
				analyses = { unusedparams = true, unreachable = false },
				codelenses = {
					generate = true, -- show the `go generate` lens.
					gc_details = true, --  // Show a code lens toggling the display of gc's choices.
				},
				usePlaceholders = false,
				completeUnimported = true,
				staticcheck = false, -- handled by null_ls
				matcher = 'fuzzy',
				diagnosticsDelay = '500ms',
				symbolMatcher = 'fuzzy',
				gofumpt = false, -- true, -- turn on for new repos, gofmpt is good but also create code turmoils
			},
		},
	}

	local coq_present, coq = pcall(require, 'coq')
	if coq_present then
		lspconfig.gopls.setup(coq.lsp_ensure_capabilities(configuration))
	else
		configuration.capabilities = require('plugins.config.lsp.capabilities')
		lspconfig.gopls.setup(configuration)
	end
end
