if pcall(require, 'fzf-lua') then
	return require('personal.lsp.fzf')
end

if pcall(require, 'telescope') then
	return require('personal.lsp.telescope')
end

return require('personal.lsp.stub')
