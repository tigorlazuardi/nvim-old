local nremap = require('vscode.mappings.utils').nremap
local opts = { silent = true, noremap = true }

nremap('<leader>e', 'workbench.view.explorer', opts)
