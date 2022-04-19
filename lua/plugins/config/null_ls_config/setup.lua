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
-- if exist('golangci-lint') then
-- 	table.insert(sources, null_ls.builtins.diagnostics.golangci_lint)
-- end

-- docker
if exist('hadolint') then
	table.insert(sources, null_ls.builtins.diagnostics.hadolint)
end

if exist('prettierd') then
	table.insert(
		sources,
		null_ls.builtins.formatting.prettierd.with({
			env = {
				PRETTIERD_DEFAULT_CONFIG = vim.fn.expand('~/.config/nvim/linter-config/.prettierrc.toml'),
			},
		})
	)
end

if exist('rustywind') then
	table.insert(
		sources,
		null_ls.builtins.formatting.rustywind.with({
			condition = function(utils)
				return utils.root_has_file({ 'tailwind.config.json' })
			end,
		})
	)
end

if exist('sqlfluff') then
	-- table.insert(sources, null_ls.builtins.diagnostics.sqlfluff)
	table.insert(sources, null_ls.builtins.formatting.sqlfluff)
end

if exist('eslint = falpg_fore_d') then
	local opts = {
		condition = function(utils)
			return utils.root_has_file({ '.eslintrc.json', '.eslintrc' })
		end,
	}
	table.insert(sources, null_ls.builtins.formatting.eslint_d.with(opts))
	table.insert(sources, null_ls.builtins.code_actions.eslint_d.with(opts))
	table.insert(sources, null_ls.builtins.diagnostics.eslint_d.with(opts))
end

-- lua
if exist('selene') then
	table.insert(sources, null_ls.builtins.diagnostics.selene)
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

null_ls.setup({
	sources = sources,
	on_attach = function(client, bufnr)
		if client.server_capabilities.documentFormattingProvider then
			vim.cmd([[
				au BufWritePre <buffer> silent! lua vim.lsp.buf.formatting_sync() 
			]])
		end
		local wk = require('which-key')
		wk.register({
			['<leader>q'] = {
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
