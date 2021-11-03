function run()
	local function diagnostic_message()
		local message = ''
		local bufnr = 0
		local line_nr = vim.api.nvim_win_get_cursor(0)[1] - 1
		local messages = {}

		for client_id, _ in ipairs(vim.lsp.buf_get_clients(bufnr)) do
			local line_diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr, line_nr, {}, client_id)
			for _, msg in ipairs(line_diagnostics) do
				table.insert(messages, msg)
			end
		end

		local severity = 5
		for _, v in ipairs(messages) do
			if v.severity < severity then
				message = v.message
				severity = v.severity
			end
		end
		return message
	end

	local function lsp_name()
		local msg = 'No Active Lsp'
		local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return msg
		end
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
			end
		end
		return msg
	end

	vim.api.nvim_command('set cmdheight=1')
	local lsp_status = require('lsp-status')
	lsp_status.config({
		status_symbol = '',
		indicator_hint = '',
	})
	lsp_status.register_progress()

	require('lualine').setup({
		options = {
			icons_enabled = true,
			theme = 'auto',
			component_separators = { '', '' },
			section_separators = { '', '' },
			disabled_filetypes = { 'dashboard' },
		},
		sections = {
			lualine_a = { 'mode' },
			lualine_b = { 'branch', 'filename', 'encoding', 'location', 'filetype' },
			lualine_c = {
				{ lsp_name, icon = ' LSP:' },
				{ lsp_status.status },
				{ diagnostic_message, color = 'LspDiagnosticsDefaultWarning' },
			},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { 'filename' },
			lualine_x = { 'location' },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		extensions = { 'nvim-tree' },
	})
end

return function(use)
	use({
		'hoob3rt/lualine.nvim',
		requires = {
			'nvim-lua/lsp-status.nvim',
			'kyazdani42/nvim-web-devicons',
		},
		config = run,
	})
end
