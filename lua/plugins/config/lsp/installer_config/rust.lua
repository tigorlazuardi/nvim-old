local path = require('plenary.path')
local capabilities = require('plugins.config.lsp.capabilities')
local server_configuration = {
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = true
		require('plugins.config.lsp.on_attach')(client, bufnr)
		local wk = require('which-key')
		wk.register({
			K = {
				function()
					require('personal.utils.with_fold_check')(require('rust-tools.hover_actions').hover_actions)
				end,
				'(LSP) Symbol Definition / Documentation',
			},
		}, { buffer = bufnr })
		vim.cmd([[
					au BufWritePre <buffer> silent! lua vim.lsp.buf.formatting_sync() 
				]])
	end,
	settings = {
		['rust-analyzer'] = {
			assist = {
				importEnforceGranularity = true,
				importPrefix = 'by_self',
			},
			checkOnSave = {
				enable = true,
				command = 'clippy',
			},
			cargo = {
				loadOutDirsFromCheck = true,
				autoreload = true,
			},
			procMacro = {
				enable = true,
			},
			diagnostics = {
				disabled = { 'unresolved-proc-macro' },
			},
		},
	},
	capabilities = capabilities,
}

local exec_name = 'rust-analyzer'
if vim.g.is_windows then
	exec_name = exec_name .. '.exe'
end

local extension_path = vim.fn.expand('$HOME/.vscode/extensions/vadimcn.vscode-lldb-1.6.10')
if vim.fn.has('wsl') == 1 then
	extension_path = vim.fn.expand('$HOME/.vscode-server/extensions/vadimcn.vscode-lldb-1.6.10')
end
local codelldb_path = path:new(extension_path, 'adapter', 'codelldb').filename
local liblldb_path = path:new(extension_path, 'lldb', 'lib', 'liblldb.so').filename

if vim.g.is_windows then
	codelldb_path = codelldb_path .. '.exe'
end

local lsp_installer_servers = require('nvim-lsp-installer.servers')
local server_available, rust_analyzer = lsp_installer_servers.get_server('rust_analyzer')
if server_available then
	rust_analyzer:on_ready(function()
		server_configuration.cmd = { path:new(rust_analyzer.root_dir, exec_name).filename }
		local rust_tools = require('rust-tools')
		rust_tools.setup({
			server = server_configuration,
			dap = {
				adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path),
			},
		})
	end)

	if not rust_analyzer:is_installed() then
		rust_analyzer:install()
	end
end
