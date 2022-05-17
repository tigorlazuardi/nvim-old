vim.keymap.set('n', '<leader>vu', function()
	local uv = vim.loop
	local stdout = uv.new_pipe()

	---@type string[]
	local result = {}
	local handle
	handle = uv.spawn('ls', {
		stdio = { nil, stdout, nil },
		args = { vim.fn.stdpath('config') .. '/.snapshots' },
	}, function(code, _signal)
		stdout:read_stop()
		stdout:close()
		handle:close()

		if code > 0 then
			vim.notify(string.format('process exited with %d code', 'error', { title = 'libuv' }))
			return
		end
		local strings = require('personal.utils.strings')
		local str = table.concat(result, '')
		result = strings.split(str, '\n')
		vim.notify(vim.inspect(result), 'info', { title = 'libuv' })
	end)

	uv.read_start(stdout, function(err, data)
		assert(not err, err)
		if data then
			table.insert(result, data)
		end
	end)
end, { desc = 'test libuv' })
