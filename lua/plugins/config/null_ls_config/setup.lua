local prequire = require('personal.utils.prequire')

local lspconfig = prequire('lspconfig')
if not lspconfig then
	return
end

local null_ls = prequire('null-ls')
if not null_ls then
	return
end

local sources = { null_ls.builtins.completion.spell.with({
	filetypes = { 'markdown', 'text' },
}) }

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
if exist('prettier_d_slim') and exist('prettierd') then
	table.insert(
		sources,
		null_ls.builtins.formatting.prettier_d_slim.with({
			condition = function(utils)
				return utils.root_has_file({
					'.prettierrc',
					'.prettierrc.json',
					'.prettierrc.yml',
					'.prettierrc.yaml',
					'.prettierrc.json5',
					'.prettierrc.js',
					'.prettierrc.cjs',
					'prettier.config.js',
					'prettier.config.cjs',
					'.prettierrc.toml',
				})
			end,
		})
	)
	table.insert(
		sources,
		null_ls.builtins.formatting.prettierd.with({
			env = {
				PRETTIERD_DEFAULT_CONFIG = vim.fn.expand('~/.config/nvim/linter-config/.prettierrc.toml'),
			},
			condition = function(utils)
				return not utils.root_has_file({
					'.prettierrc',
					'.prettierrc.json',
					'.prettierrc.yml',
					'.prettierrc.yaml',
					'.prettierrc.json5',
					'.prettierrc.js',
					'.prettierrc.cjs',
					'prettier.config.js',
					'prettier.config.cjs',
					'.prettierrc.toml',
				})
			end,
		})
	)
elseif exist('prettierd') and not exist('prettier_d_slim') then
	table.insert(
		sources,
		null_ls.builtins.formatting.prettierd.with({
			env = {
				PRETTIERD_DEFAULT_CONFIG = vim.fn.expand('~/.config/nvim/linter-config/.prettierrc.toml'),
			},
		})
	)
elseif exist('prettier_d_slim') and not exist('prettierd') then
	table.insert(sources, null_ls.builtins.formatting.prettier_d_slim)
end

if exist('rustywind') then
	table.insert(sources, null_ls.builtins.formatting.rustywind)
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

if exist('sqlformat') then
	table.insert(sources, null_ls.builtins.formatting.sqlformat)
end

if exist('clang-format') then
	table.insert(
		sources,
		null_ls.builtins.formatting.clang_format.with({
			filetypes = { 'proto', 'c', 'cpp', 'cs', 'java' },
		})
	)
end

if exist('codespell') then
	table.insert(sources, null_ls.builtins.diagnostics.codespell)
end

if exist('curl') then
	table.insert(sources, null_ls.builtins.hover.dictionary)
end

if exist('proselint') then
	table.insert(sources, null_ls.builtins.diagnostics.proselint)
end

-- if exist('golines') then
-- 	table.insert(sources, null_ls.builtins.formatting.golines)
-- end

-- if exist('gofumpt') then
-- 	table.insert(sources, null_ls.builtins.formatting.gofumpt)
-- end

null_ls.setup({
	sources = sources,
	on_attach = function(client, bufnr)
		-- client.resolved_capabilities.document_highlight = true
		if client.resolved_capabilities.document_formatting then
			vim.cmd([[
				au BufWritePre <buffer> silent! lua vim.lsp.buf.formatting_sync() 
			]])
		end
		local wk = require('which-key')
		wk.register({
			q = {
				name = 'quick',
				f = { '<cmd>lua vim.lsp.buf.formatting_sync()<cr>', 'Format Current Buffer' },
			},
			K = {
				function()
					require('personal.utils.with_fold_check')(vim.lsp.buf.hover)
				end,
				'(LSP) Symbol Definition / Documentation',
			},
		}, {
			buffer = bufnr,
		})
	end,
})
