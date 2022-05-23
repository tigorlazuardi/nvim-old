return function(use)
	use({
		'ibhagwan/fzf-lua',
		requires = {
			-- optional for icon support
			{ 'kyazdani42/nvim-web-devicons' },
			{
				'junegunn/fzf',
				run = './install --bin',
				disable = vim.fn.exepath('sk') ~= '' or vim.fn.exepath('fzf') ~= '',
			},
		},
		disable = vim.g.is_windows,
		after = { 'telescope.nvim' },
		config = function()
			local fzf_lua = require('fzf-lua')

			local nmap = function(lhs, rhs, opts)
				opts = opts or {}
				vim.keymap.set('n', lhs, rhs, opts)
			end
			nmap('<c-f>', function()
				fzf_lua.files()
			end, { desc = 'Files Picker' })
			nmap('<c-b>', function()
				fzf_lua.buffers()
			end, { desc = 'Buffer Picker' })
			nmap('<c-t>', function()
				fzf_lua.live_grep_native()
			end, 'Live Grep (Workspace)')
			nmap('<c-y>', function()
				fzf_lua.lgrep_curbuf()
			end, { desc = 'Live Grep (Current Buffer)' })

			fzf_lua.setup({
				fzf_bin = vim.fn.exepath('sk') ~= '' and 'sk' or 'fzf',
				winopts = {
					preview = {
						default = vim.fn.exepath('bat') ~= '' and 'bat' or 'builtin',
					},
				},
			})
		end,
	})
end
