local nremap = require('vscode.mappings.utils').nremap

local opts = { silent = true, noremap = true }

nremap(']t', 'workbench.action.nextEditorInGroup', opts)
nremap('[t', 'workbench.action.previousEditorInGroup', opts)
nremap('[T', 'workbench.action.firstEditorInGroup', opts)
nremap(']T', 'workbench.action.lastEditorInGroup', opts)
nremap('gt', 'workbench.action.quickOpen', opts)
