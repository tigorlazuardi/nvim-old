if vim.fn.exepath('nvr') ~= '' then
	vim.env.GIT_EDITOR = 'nvr --cc split --remote-wait'
	vim.cmd([[
		augroup nvr_files
			au!
			au FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
		augroup end
	]])
end
