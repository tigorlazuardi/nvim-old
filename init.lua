if vim.g.vscode then
	require('vscode')
	return
end

require('globals')
require('mappings')
require('settings')
require('plugins')
