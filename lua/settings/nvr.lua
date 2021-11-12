if vim.fn.exepath('nvr') ~= '' then
	vim.env.GIT_EDITOR = 'nvr --cc split --remote-wait'
end
