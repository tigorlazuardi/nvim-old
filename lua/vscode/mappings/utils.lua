local M = {}

M.nremap = function(key, vscode_command, opts)
	vim.api.nvim_set_keymap('n', key, [[<cmd>call VSCodeCall(']] .. vscode_command .. [[')<cr>]], opts)
end

return M
