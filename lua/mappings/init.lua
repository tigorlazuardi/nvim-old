local opts = { silent = true, noremap = true }

local remap = vim.api.nvim_set_keymap

vim.cmd([[let mapleader = " "]])

-- save all <c-s>
remap('n', '<c-s>', ':wa<cr>', opts)
remap('n', 'H', 'zc', opts)
remap('n', 'L', 'zo', opts)
remap('n', ']t', ':bn!<CR>', opts)
remap('n', '[t', ':bp!<cr>', opts)
remap('n', 'Q', 'q', opts)
remap('n', 'q', '<nop>', opts)

-- require('mappings.line_swap')
require('mappings.gx')
