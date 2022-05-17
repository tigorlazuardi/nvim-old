vim.keymap.set('n', '<leader>pU', function()
	local uv = vim.loop
	local stdout = uv.new_pipe()
	local result = {}
	local handle
	handle = uv.spawn('/usr/bin/ls', {
		stdio = { nil, stdout, nil },
		args = { '/home/tigor/.config/nvim/.snapshots' },
	}, function(code, _signal)
		if code > 0 then
			vim.notify(string.format('process exited with %d code', 'error', { title = 'libuv' }))
		end
		stdout:read_stop()
		stdout:close()
		handle:close()
		result = table.concat(result, '')
		result = require('personal.utils.strings').split(result, '\n')
		vim.notify(vim.inspect(result))
	end)

	uv.read_start(stdout, function(err, data)
		assert(not err, err)
		if data then
			table.insert(result, data)
		end
	end)
end, { desc = 'test libuv' })
