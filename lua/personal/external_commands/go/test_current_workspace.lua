local utils = require('go.utils')
local get_build_tags = require('personal.external_commands.go.get_build_tags')
local empty = utils.empty

local M = {}

function M.get_cmd(...)
	local args = { ... }
	local workfolder = utils.work_path()
	local fpath = workfolder .. utils.sep() .. '...'
	local tags, args2 = get_build_tags(args)

	local cmd = { 'go', 'test', '-v', '-count=1' }
	if not empty(tags) then
		cmd = vim.list_extend(cmd, tags)
	end
	if not empty(args2) then
		cmd = vim.list_extend(cmd, args2)
	end

	table.insert(cmd, fpath)
	return cmd
end

function M.run(...)
	local cmdTable = M.get_cmd(...)
	if cmdTable == nil then
		return
	end

	local workfolder = utils.work_path()
	local test_name = vim.fn.fnamemodify(workfolder, ':t')
	require('personal.external_commands.go.spawn_split')(cmdTable, test_name)
end
return M
