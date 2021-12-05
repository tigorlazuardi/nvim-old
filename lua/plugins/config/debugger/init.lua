local function config()
	vim.cmd('PackerLoad nvim-dap')
	vim.cmd('PackerLoad nvim-dap-virtual-text')
	vim.cmd('PackerLoad telescope-dap.nvim')

	require('dapui').setup()

	require('plugins.config.debugger.go')
	require('plugins.config.debugger.chrome_js')
	require('plugins.config.debugger.node_js')
	require('plugins.config.debugger.nvim')

	require('telescope').load_extension('dap')

	local wk = require('which-key')

	_G.dapui_eval_twice = function()
		require('dapui').eval()
		require('dapui').eval()
	end

	_G.dap_close = function()
		require('dap').disconnect()
		require('dap').close()
		require('dap').repl.close()
		require('dapui').close()
	end

	wk.register({
		['<leader>d'] = {
			name = '+debugger',
			c = { [[<cmd>lua require('dapui').toggle()<cr>]], 'Open Debugger' },
			b = { [[<cmd>lua require('dap').toggle_breakpoint()<cr>]], 'Toggle Breakpoints' },
			e = {
				[[<cmd>lua require('dap').set_exception_breakpoints({"all"})<cr>]],
				'Set Exception Breakpoints (All)',
			},
			n = { [[<cmd>lua require('dap').continue()<cr>]], 'Start/Continue Debugger' },
			N = { [[<cmd>lua require('dap').run_last()<cr>]], 'Run Last Debugger' },
			h = { [[<cmd>lua require('dap').step_out()<cr>]], 'Step Out' },
			l = { [[<cmd>lua require('dap').step_over()<cr>]], 'Step Over' },
			j = { [[<cmd>lua require('dap').step_into()<cr>]], 'Step Into' },
			r = { [[<cmd>lua require('dap').repl.open({}, 'vsplit')<cr>]], 'Open Repl' },
			k = { [[<cmd>lua _G.dapui_eval_twice()<cr>]], 'Debug Hover' },
			s = { [[<cmd>lua require('dap.ui.variables').scopes()<cr>]], 'Scope' },
			S = { [[<cmd>lua _G.dap_close()<cr>]], 'Stop Debugger' },
			B = { [[<cmd>lua require('telescope').extensions.dap.list_breakpoints({})<cr>]], 'List Breakpoints' },
			x = { [[<cmd>lua require('telescope').extensions.dap.commands({})<cr>]], 'List Commands' },
			v = { [[<cmd>lua require('telescope').extensions.dap.variables({})<cr>]], 'List Variables' },
			f = { [[<cmd>lua require('telescope').extensions.dap.frames({})<cr>]], 'List Frames' },
			m = { [[<cmd>lua require('telescope').extensions.dap.configurations({})<cr>]], 'List Configurations' },
		},
	})

	wk.register({
		['<leader>dk'] = {
			[[<cmd>lua require('dap.ui.variables').visual_hover()<cr>]],
			'Debug Hover (Visual)',
		},
	}, {
		mode = 'v',
	})

	vim.cmd([[command! DapLoadVSCode lua require('dap.ext.vscode').load_launchjs()]])

	vim.cmd([[
		augroup dap_load_vscode
			au!
			au DirChanged * silent! lua require('dap.ext.vscode').load_launchjs()
		augroup end
	]])
	-- broken format due to emoji. have to be ignored.
	vim.fn.sign_define('DapBreakpoint', { text = '', texthl = '', linehl = '', numhl = '' })
	vim.fn.sign_define('DapStopped', { text = '', texthl = '', linehl = '', numhl = '' })

	require('nvim-dap-virtual-text').setup({
		all_frames = true,
	})
end

return function(use)
	use({
		'rcarriga/nvim-dap-ui',
		event = 'BufEnter',
		requires = {
			{ 'mfussenegger/nvim-dap', opt = true },
			{ 'theHamsta/nvim-dap-virtual-text', opt = true },
			{ 'nvim-telescope/telescope-dap.nvim', opt = true },
			{ 'jbyuki/one-small-step-for-vimkind', opt = true },
		},
		wants = { 'which-key.nvim', 'telescope.nvim', 'nvim-treesitter' },
		config = config,
	})
end
