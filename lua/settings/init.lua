local c = vim.api.nvim_command

c('set nocompatible') -- disable compability with vi
c('set mouse=va') -- mouse to paste middleclick ('v'), and select via click ('a')
c('set cursorline') -- highlight cursors line

c('set nu') -- line numbers
c('set completeopt=menuone,noinsert,noselect')
c('set shortmess+=c')

c('set title')
c([[
	augroup titlestringer
		au!
		au VimEnter * set titlestring=%{getcwd()}
		au DirChanged * set titlestring=%{getcwd()}
	augroup end
]])

require('settings.indent')
require('settings.clipboard')
require('settings.search')
require('settings.window')
require('settings.neovide')
require('settings.nvr')
-- require('settings.backup')

vim.cmd('set nobackup nowritebackup noswapfile noundofile')

-- Line break by words, not by characters
c('set wrap linebreak')
