local M = {}
local methods = require('null-ls.methods').internal
local helpers = require('null-ls.helpers')
-- local null_ls = require("null-ls")

M.method = methods.DIAGNOSTICS

M.filetypes = { 'go' }

local args = {
	'--out-format=json',
	'run',
	'-c',
	vim.fn.stdpath('config') .. '/linter-config/.golangci.toml',
}

M.generator = helpers.generator_factory({
	command = 'golangci-lint',
	args = args,
	to_stdin = false,
	to_stderr = false,
	format = 'json_raw',
	on_output = function(params)
		if params.err or not params.output then
			return nil
		end

		local decoded = params.output

		if decoded['Issues'] == nil or type(decoded['Issues']) == 'userdata' then
			return nil
		end

		local diagnostics = {}
		for _, issue in ipairs(decoded['Issues']) do
			local filename = vim.fn.getcwd() .. '/' .. issue.Pos.Filename
			local col
			if issue.Pos.Column - 1 < 0 then
				col = 0
			else
				col = issue.Pos.Column - 1
			end

			local current_file = vim.api.nvim_buf_get_name(params.bufnr)
			if current_file == filename then
				table.insert(diagnostics, {
					row = issue.Pos.Line,
					col = col,
					source = issue.FromLinter,
					message = issue.Text,
					severity = 2,
				})
			end
		end

		return diagnostics
	end,
})

return M
