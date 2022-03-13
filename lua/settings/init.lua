vim.cmd('set nocompatible') -- disable compatibility with vi
vim.cmd('set mouse=va') -- mouse to paste middleclick ('v'), and select via click ('a')
vim.cmd('set cursorline') -- highlight cursors line
vim.cmd('set nu') -- line numbers
vim.cmd('set completeopt=menuone,noinsert,noselect')
vim.cmd('set shortmess+=c')
vim.cmd([[
	autocmd filetype lua,go,javascript,typescript setlocal colorcolumn=120
]])

vim.cmd('set title')
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
require('settings.filetypes')
-- require('settings.backup')

vim.cmd('set nobackup nowritebackup noswapfile noundofile')
-- vim.cmd([[set list listchars=tab:\›\ ,trail:-,extends:>,precedes:<,eol:¬,space:·]])

-- Line break by words, not by characters
vim.cmd('set wrap linebreak')

-- trigger autoread when file changes on disk
vim.cmd([[set autoread]])
-- trigger autoread when files changes on disk
vim.cmd([[
	autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
]])
-- notification after file change
vim.cmd([[
	autocmd FileChangedShellPost * lua vim.notify("File Reloaded", "warn", {title = "Buffer Reload", timeout = 500})
]])
