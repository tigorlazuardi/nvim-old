local nremap = require('vscode.mappings.utils').nremap
local opts = { silent = true, noremap = true }

nremap('gs', 'workbench.action.gotoSymbol', opts)
nremap('gS', 'workbench.action.showAllSymbols', opts)
nremap('<leader>ff', 'workbench.action.findInFiles', opts)

vim.cmd([[
	xmap gc  <Plug>VSCodeCommentary
	nmap gc  <Plug>VSCodeCommentary
	omap gc  <Plug>VSCodeCommentary
	nmap gcc <Plug>VSCodeCommentaryLine
]])

-- error navigation
nremap('gnn', 'editor.action.marker.next', opts)
nremap('gpp', 'editor.action.marker.prev', opts)
nremap('gn', 'editor.action.marker.nextInFiles', opts)
nremap('gp', 'editor.action.marker.prevInFiles', opts)
