local dap = require('dap')

local function dap_read(err, chunk)
	assert(not err, err)
	if chunk then
		vim.schedule(function()
			require('dap.repl').append(chunk)
		end)
	end
end

dap.adapters.go = function(callback, _config)
	local stdout = vim.loop.new_pipe(false)
	local stderr = vim.loop.new_pipe(false)
	local port = 38697
	local handle
	local pid_or_err
	local opts = {
		stdio = { nil, stdout, stderr },
		args = { 'dap', '-l', '127.0.0.1:' .. port },
		detached = true,
	}
	handle, pid_or_err = vim.loop.spawn('dlv', opts, function(code)
		stdout:close()
		stderr:close()
		handle:close()
		if code ~= 0 then
			print('dlv exited with code', code)
		end
	end)
	assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))
	stdout:read_start(dap_read)
	stderr:read_start(dap_read)
	-- Wait for delve to start
	vim.defer_fn(function()
		callback({ type = 'server', host = '127.0.0.1', port = port })
	end, 100)
end
-- end

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
	{
		type = 'go',
		name = 'Launch main.go',
		mode = 'debug',
		request = 'launch',
		program = '${workspaceFolder}',
		dlvToolPath = vim.fn.exepath('dlv'),
	},
	{
		type = 'go',
		name = 'Debug test', -- configuration for debugging test files
		request = 'launch',
		mode = 'test',
		program = '${file}',
		dlvToolPath = vim.fn.exepath('dlv'),
	},
	-- works with go.mod packages and sub packages
	{
		type = 'go',
		name = 'Debug test (go.mod)',
		request = 'launch',
		mode = 'test',
		program = './${relativeFileDirname}',
		dlvToolPath = vim.fn.exepath('dlv'),
	},
}

_G.__dap_config = {}
_G.__dap_config.go = dap.configurations.go

vim.cmd([[
	command! DapRestoreGo lua require('dap').configurations.go = _G.__dap_config.go
]])
