local remap = vim.api.nvim_set_keymap

local options = { silent = true, noremap = true }

remap('n', '<a-j>', ':m .+1<cr>==', options)
remap('n', '<a-k>', ':m .-2<cr>==', options)
remap('i', '<a-j>', '<esc>:m .+1<cr>==gi', options)
remap('i', '<a-k>', '<esc>:m .-2<cr>==gi', options)
remap('v', '<a-j>', [[:m '>+1<CR>gv=gv]], options)
remap('v', '<a-k>', [[:m '<-2<CR>gv=gv]], options)
