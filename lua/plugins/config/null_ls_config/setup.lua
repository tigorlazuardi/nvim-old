local prequire = require('personal.utils.prequire')

local lspconfig = prequire('lspconfig')
if not lspconfig then
	return
end

local null_ls = prequire('null-ls')
if not null_ls then
	return
end

local sources = { null_ls.builtins.completion.spell }

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
	table.insert(sources, null_ls.builtins.diagnostics.golangci_lint)
end

-- docker
if exist('hadolint') then
	table.insert(sources, null_ls.builtins.diagnostics.hadolint)
end

-- js, ts
if exist('prettierd') then
	table.insert(sources, null_ls.builtins.formatting.prettierd)
end

if exist('eslint_d') then
	table.insert(sources, null_ls.builtins.formatting.eslint_d)
	-- table.insert(sources, null_ls.builtins.diagnostics.eslint_d)
end

-- lua
if exist('selene') then
	table.insert(sources, null_ls.builtins.diagnostics.selene)
end

if exist('taplo') then
	table.insert(sources, null_ls.builtins.formatting.taplo)
end

if exist('clang-format') then
	table.insert(
		sources,
		null_ls.builtins.formatting.clang_format.with({
			filetypes = { 'proto', 'c', 'cpp', 'cs', 'java' },
		})
	)
end

if exist('curl') then
	table.insert(sources, null_ls.builtins.hover.dictionary)
end

if exist('proselint') then
	table.insert(sources, null_ls.builtins.diagnostics.proselint)
end

null_ls.setup({
	sources = sources,
	diagnostics_format = '(#{s}) #{m}',
	on_attach = function(client, bufnr)
		if client.resolved_capabilities.document_formatting then
			vim.cmd([[
				au BufWritePost <buffer> lua vim.lsp.buf.formatting_sync() 
			]])
		end
		require('plugins.config.lsp.on_attach')(client, bufnr)
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
