local c = vim.api.nvim_command
c('set clipboard+=unnamedplus')

vim.cmd([[
    augroup highlight_yank
        autocmd!
        autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
    augroup end
]])
