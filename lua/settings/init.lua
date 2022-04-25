vim.o.compatible = false -- disable compatibility with vi
vim.o.mouse = 'va' -- mouse to paste middleclick ('v'), and select via click ('a')
vim.o.cursorline = true -- show cursorline

vim.o.number = true
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.o.shortmess = vim.o.shortmess .. 'c'

vim.o.title = true
local titlestringer_group = vim.api.nvim_create_augroup('titlestringer', { clear = true })
vim.api.nvim_create_autocmd({ 'DirChanged', 'VimEnter' }, {
	pattern = '*',
	group = titlestringer_group,
	callback = function()
		vim.o.titlestring = 'nvim - ' .. vim.fn.getcwd()
	end,
	desc = 'Changes title on DirChanged or first enter vim',
})

require('settings.indent')
require('settings.clipboard')
require('settings.search')
require('settings.window')
require('settings.neovide')
require('settings.nvr')
require('settings.filetypes')
-- require('settings.backup')

vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.undofile = false

-- vim.cmd([[set list listchars=tab:\›\ ,trail:-,extends:>,precedes:<,eol:¬,space:·]])

-- Line break by words, not by characters
vim.o.wrap = true
vim.o.linebreak = true

-- trigger autoread when file changes on disk
vim.o.autoread = true
-- trigger autoread when files changes on disk

local reread_group = vim.api.nvim_create_augroup('force_reread', { clear = true })
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
	pattern = '*',
	callback = function()
		if vim.fn.mode() ~= 'c' then
			vim.cmd('silent! checktime')
		end
	end,
	desc = 'Trigger autoread when files changes on disk',
	group = reread_group,
})

vim.api.nvim_create_autocmd({ 'FileChangedShellPost' }, {
	pattern = { '*' },
	callback = function()
		vim.notify('File Reloaded', 'warn', { title = 'Buffer Reload', timeout = 500 })
	end,
	desc = 'Reload buffer when file changes on disk',
	group = reread_group,
})
