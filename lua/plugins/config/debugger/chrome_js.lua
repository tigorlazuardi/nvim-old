local dap = require('dap')

dap.adapters.node2 = {
	type = 'executable',
	command = 'node',
	args = { os.getenv('HOME') .. '/.local/npm/vscode-chrome-debug/out/src/chromeDebug.js' },
}

dap.configurations.javascriptreact = { -- change this to javascript if needed
	{
		type = 'chrome',
		request = 'attach',
		name = 'ChromeJS',
		program = '${file}',
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = 'inspector',
		port = 9222,
		webRoot = '${workspaceFolder}',
	},
}

dap.configurations.typescriptreact = { -- change to typescript if needed
	{
		type = 'chrome',
		request = 'attach',
		name = 'ChromeTS',
		program = '${file}',
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = 'inspector',
		port = 9222,
		webRoot = '${workspaceFolder}',
	},
}
