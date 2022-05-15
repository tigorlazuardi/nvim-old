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

local function rolling_snapshot()
	local util = require('packer.util')
	local snapshot_path = util.join_paths(vim.fn.stdpath('config'), '.snapshots')
	local latest_snapshot_path = util.join_paths(snapshot_path, 'latest.json')
	local file_iterator = io.popen('ls ' .. snapshot_path)
	local files = {}

	for file in file_iterator:lines() do
		table.insert(files, file)
	end

	if vim.fn.filereadable(latest_snapshot_path) == 1 then
		os.remove(latest_snapshot_path)
	end

	file_iterator:close()

	packer.sync()
	vim.api.nvim_create_autocmd('User', {
		pattern = { 'PackerComplete' },
		once = true,
		callback = function()
			if #files == 0 then
				packer.snapshot(os.date('%Y-%m-%d') .. '.json')
				packer.snapshot('latest.json')
				vim.notify('Snapshot Created', 'info', { title = 'Packer' })
				return
			end

			--- only support 10 snapshots
			if #files > 10 then
				table.sort(files, function(a, b)
					--- ensure latest.json is always first with oldest file on second index
					return a > b
				end)
				--- remove oldest file
				os.remove(util.join_paths(snapshot_path, files[2]))
			end

			packer.snapshot(os.date('%Y-%m-%d') .. '.json')
			packer.snapshot('latest.json')
			vim.notify('Snapshot Created', 'info', { title = 'packer.nvim' })
		end,
	})
end

vim.keymap.set('n', '<leader>pU', rolling_snapshot, { desc = 'Update and Roll Snapshot' })
vim.api.nvim_create_user_command('PackerRollingSnapshot', rolling_snapshot, {})

return packer
