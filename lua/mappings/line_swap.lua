vim.cmd([[
    nnoremap <silent> <A-j> :m .+1<CR>==
    nnoremap <silent> <A-k> :m .-2<CR>==
    inoremap <silent> <A-j> <Esc>:m .+1<CR>==gi
    inoremap <silent> <A-k> <Esc>:m .-2<CR>==gi
    vnoremap <silent> <A-j> :m '>+1<CR>gv=gv
    vnoremap <silent> <A-k> :m '<-2<CR>gv=gv
]])
