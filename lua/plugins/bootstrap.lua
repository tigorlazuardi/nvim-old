local fn = vim.fn
local cmd = vim.cmd

pcall(cmd, 'packadd packer.nvim')
local present, packer = pcall(require, 'packer')

if not present then
	local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
	print('cloning packer...')
	vim.fn.delete(install_path, 'rf')
	vim.fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', '--depth', '1', install_path })
	cmd('packadd packer.nvim')
	present, packer = pcall(require, 'packer')
	if present then
		print('Packer cloned successfully')
	else
		error('Failed to clone packer to ' .. install_path .. ' reason: ', packer)
		return
	end
end

packer.reset()

packer.init({
	display = {
		open_fn = function()
			return require('packer.util').float({ border = 'single' })
		end,
		prompt_border = 'single',
	},
	snapshot = 'latest.json',
	snapshot_path = require('packer.util').join_paths(vim.fn.stdpath('config'), '.snapshots'),
	max_jobs = 16,
	auto_clean = true,
	compile_on_sync = true,
})

vim.api.nvim_create_autocmd('User', {
	pattern = { 'PackerCompileDone' },
	desc = 'Create snapshot upon packer compile when snapshot does not exist',
	callback = function()
		local util = require('packer.util')
		local snapshot_path = util.join_paths(vim.fn.stdpath('config'), '.snapshots')
		local latest_snapshot_path = util.join_paths(snapshot_path, 'latest.json')
		local list_cmd = 'ls ' .. snapshot_path
		if vim.g.is_windows then
			list_cmd = 'dir /b ' .. snapshot_path
		end
		local file_iterator = io.popen(list_cmd)
		if not file_iterator then
			vim.notify('Failed to run "ls" command', 'error')
			return
		end
		local files = {}
		local current_day_snapshot = os.date('%Y-%m-%d') .. '.json'
		local current_day_snapshot_path = util.join_paths(snapshot_path, current_day_snapshot)

		for file in file_iterator:lines() do
			table.insert(files, file)
		end

		file_iterator:close()

		if vim.fn.filereadable(latest_snapshot_path) == 0 then
			packer.snapshot('latest.json')
		end

		if (#files <= 10) and (vim.fn.filereadable(current_day_snapshot_path) == 0) then
			packer.snapshot(current_day_snapshot)
		end
	end,
})

local function update_and_roll()
	local util = require('packer.util')
	local snapshot_path = util.join_paths(vim.fn.stdpath('config'), '.snapshots')
	local latest_snapshot_path = util.join_paths(snapshot_path, 'latest.json')
	local list_cmd = 'ls ' .. snapshot_path
	if vim.g.is_windows then
		list_cmd = 'dir /b ' .. snapshot_path
	end
	local file_iterator = io.popen(list_cmd)
	assert(file_iterator, 'failed to list files')
	local files = {}
	local current_day_snapshot = os.date('%Y-%m-%d') .. '.json'
	local current_day_snapshot_path = util.join_paths(snapshot_path, current_day_snapshot)

	for file in file_iterator:lines() do
		table.insert(files, file)
	end

	file_iterator:close()

	if vim.fn.filereadable(latest_snapshot_path) == 1 then
		vim.notify(([[removed snapshot file: '%s']]):format('latest.json'), 'info', { title = 'Update and Roll' })
		os.remove(latest_snapshot_path)
	end

	if vim.fn.filereadable(current_day_snapshot_path) == 1 then
		vim.notify(
			([[removed snapshot file: '%s']]):format(current_day_snapshot),
			'info',
			{ title = 'Update and Roll' }
		)
		os.remove(current_day_snapshot_path)
	end

	while #files > 11 do
		os.remove(util.join_paths(snapshot_path, files[#files - 1]))
		local removed = table.remove(files, #files - 1)
		vim.notify(([[removed snapshot file: '%s']]):format(removed), 'info', { title = 'Update and Roll' })
	end

	packer.sync()
end

local desc = { desc = 'Update and Roll snapshot upon packer sync' }

vim.keymap.set('n', '<leader>pU', update_and_roll, desc)
vim.api.nvim_create_user_command('PackerUpdateAndRoll', update_and_roll, desc)

return packer
