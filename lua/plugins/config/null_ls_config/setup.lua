local null_ls = require('null-ls')
local lspconfig = require('lspconfig')

local sources = {}

local function exist(bin)
	return vim.fn.exepath(bin) ~= ''
end

-- lua
if exist('stylua') then
	table.insert(sources, null_ls.builtins.formatting.stylua)
end

-- shell script
if exist('shellcheck') then
	table.insert(sources, null_ls.builtins.diagnostics.shellcheck)
end

-- shell script
if exist('shfmt') then
	table.insert(sources, null_ls.builtins.formatting.shfmt)
end

-- golang
if exist('golangci-lint') then
	table.insert(sources, require('plugins.config.null_ls_config.golangcilint'))
end

-- docker
if exist('hadolint') then
	table.insert(sources, null_ls.builtins.diagnostics.hadolint)
end

-- js, ts
if exist('prettierd') then
	table.insert(sources, null_ls.builtins.formatting.prettierd)
end

-- lua
if exist('selene') then
	table.insert(sources, null_ls.builtins.diagnostics.selene)
end

null_ls.config({ sources = sources })

if lspconfig['null-ls'] then
	lspconfig['null-ls'].setup({
		on_attach = function(client, bufnr)
			if client.resolved_capabilities.document_formatting then
				vim.cmd([[
					augroup null_ls_format
						au!		
						au BufWritePost <buffer> lua vim.lsp.buf.formatting_sync() 
					augroup end
				]])
			end
			local wk = require('which-key')
			wk.register({
				q = {
					name = 'quick',
					f = { '<cmd>lua vim.lsp.buf.formatting_sync()<cr>', 'Format Current Buffer' },
				},
			}, {
				buffer = bufnr,
			})
		end,
	})
end
