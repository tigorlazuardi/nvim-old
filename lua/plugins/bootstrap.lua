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
	max_jobs = 16,
	auto_clean = true,
	compile_on_sync = true,
})

return packer
