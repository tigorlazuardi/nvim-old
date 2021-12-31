local function config()
	local prequire = require('personal.utils.prequire')
	local packer = prequire('packer')
	if not packer then
		return
	end
	require('dapui').setup({
		mappings = { edit = 'i', remove = 'd' },
	})

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

	vim.cmd([[au FileType dap-repl setlocal wrap linebreak]])
	vim.cmd([[au FileType dap-repl lua require('dap.ext.autocompl').attach()]])

	wk.register({
		['<leader>d'] = {
			name = '+debugger',
			d = { [[<cmd>lua require('dapui').toggle()<cr>]], 'Open Debugger' },
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
			k = { [[<cmd>silent! lua _G.dapui_eval_twice()<cr>]], 'Debug Hover' },
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

	_G.load_launchjs = function()
		require('dap.ext.vscode').load_launchjs()
		local dap = require('dap')
		local dlv = vim.fn.exepath('dlv')
		if dlv ~= '' then
			for _, cfg in ipairs(dap.configurations.go) do
				cfg.dlvToolPath = dlv
			end
		end
	end

	vim.cmd([[command! DapLoadVSCode lua _G.load_launchjs()]])

	vim.cmd([[
		augroup dap_load_vscode
			au!
			au DirChanged * silent! lua _G.load_launchjs()
		augroup end
	]])
	-- broken format due to emoji. have to be ignored.
	vim.fn.sign_define('DapBreakpoint', { text = '', texthl = '', linehl = '', numhl = '' })
	vim.fn.sign_define('DapStopped', { text = '', texthl = '', linehl = '', numhl = '' })

	require('nvim-dap-virtual-text').setup({
		all_frames = true,
	})

	require('dap').listeners.after.event_initialized['dapui_config'] = function()
		require('dapui').open()
	end
end

return function(use)
	use({
		'tigorlazuardi/nvim-dap-ui',
		requires = {
			{ 'mfussenegger/nvim-dap' },
			{ 'theHamsta/nvim-dap-virtual-text' },
			{ 'nvim-telescope/telescope-dap.nvim' },
			{ 'jbyuki/one-small-step-for-vimkind' },
		},
		wants = { 'which-key.nvim', 'telescope.nvim', 'nvim-treesitter' },
		config = config,
	})
end
