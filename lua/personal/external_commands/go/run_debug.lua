local dap = require('dap')

---temporarily replaces dap configurations for go and execute said config.
---
---run the returned callback to restore to old configurations.
---@param name string
---@param mode string
---@param program string
---@param args table table of strings
---@return function callback returns callback to restore previous configuration
return function(name, mode, program, args)
	local old = vim.deepcopy(dap.configurations.go)
	local cfg = {
		type = 'go',
		request = 'launch',
		name = name,
		mode = mode,
		program = program,
		args = args,
		dlvToolPath = vim.fn.exepath('dlv'),
	}
	dap.configurations.go = { cfg }

	vim.notify(
		string.format('Executing Debugger %s %s %s', cfg.dlvToolPath, table.concat(cfg.args, ' '), cfg.program),
		'info',
		{ title = name }
	)

	dap.continue()
	return function()
		dap.configurations.go = old
	end
end
