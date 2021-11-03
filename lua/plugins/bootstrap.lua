local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local not_installed = fn.empty(fn.glob(install_path)) > 0
local should_sync = false

if not_installed then
	print('Cloning packer...')
	fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
	should_sync = true
end

local packer = require('packer')
local util = require('packer.util')

packer.init({
	display = {
		open_fn = function()
			return require('packer.util').float({ border = 'single' })
		end,
		prompt_border = 'single',
	},
	git = {
		clone_timeout = 600, -- Timeout, in seconds, for git clones
	},
	auto_clean = true,
	compile_on_sync = true,
	compile_path = util.join_paths(vim.fn.stdpath('config'), 'plugin', 'packer_nvim.lua'),
})

return packer, should_sync
