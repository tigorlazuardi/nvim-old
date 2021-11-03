require('settings.clipboard')
require('settings.search')

local c = vim.api.nvim_command

-- disable background buffer for neovim-vscode
c('set nohidden')
