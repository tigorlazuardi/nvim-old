local config_dir = vim.fn.stdpath('config')
local swap = config_dir .. '/backup'
local set = vim.api.nvim_set_option

pcall(vim.fn.mkdir, swap, 'p', 0777)

local dir = swap .. '/'

set('backupdir', dir)
set('directory', dir)
set('undodir', dir)
