local c = vim.api.nvim_command

c('set nocompatible') -- disable compability with vi
c('set mouse=va') -- mouse to paste middleclick ('v'), and select via click ('a')
c('set cursorline') -- highlight cursors line

c('set nu') -- line numbers
c('set completeopt=menuone,noinsert,noselect')
c('set shortmess+=c')

c('set title')
vim.cmd([[
	augroup titlestringer
		au!
		au DirChanged * let &titlestring = 'nvim - ' . getcwd()
		au VimEnter * let &titlestring = 'nvim - ' . getcwd()
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
vim.cmd([[set list listchars=tab:\›\ ,trail:-,extends:>,precedes:<,eol:¬,space:·]])

-- Line break by words, not by characters
c('set wrap linebreak')
