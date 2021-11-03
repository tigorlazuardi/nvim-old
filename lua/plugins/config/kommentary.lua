local run = function()
	local present, _ = pcall(require, 'kommentary.config')
	if not present then
		return
	end
	require('kommentary.config').configure_language('default', { prefer_single_line_comments = true })
end

return function(use)
	use({ 'b3nj5m1n/kommentary', disable = vim.g.vscode, config = run })
end
