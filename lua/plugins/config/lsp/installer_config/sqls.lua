local path = require('nvim-lsp-installer.path')
local install_root_dir = path.concat({ vim.fn.stdpath('data'), 'lsp_servers' })

local opts = { cmd = { install_root_dir .. '/sqls/sqls', '-config', vim.fn.expand('$HOME/.config/sqls/config.yml') } }

return opts
