local function run()
	local toggleterm = require('toggleterm')
	toggleterm.setup({
		-- size can be a number or function which is passed the current terminal
		size = function(term)
			if term.direction == 'horizontal' then
				return 15
			elseif term.direction == 'vertical' then
				return vim.o.columns * 0.4
			else
				return 20
			end
		end,
		open_mapping = [[<F5>]],
		hide_numbers = true, -- hide the number column in toggleterm buffers
		shade_terminals = true,
		shade_filetypes = {},
		shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
		start_in_insert = true,
		insert_mappings = true, -- whether or not the open mapping applies in insert mode
		persist_size = true,
		direction = 'float',
		close_on_exit = true, -- close the terminal window when the process exits
		float_opts = {
			-- The border key is *almost* the same as 'nvim_win_open'
			-- see :h nvim_win_open for details on borders however
			-- the 'curved' border is a custom border type
			-- not natively supported but implemented in this plugin.
			border = 'double',
			winblend = 3,
			highlights = { border = 'Normal', background = 'Normal' },
		},
	})

	-- local term = require('toggleterm.terminal').Terminal
	-- local lazygit = term:new({ cmd = 'lazygit', hidden = true })
	--
	-- ---@diagnostic disable-next-line
	-- function _lazygit_toggle()
	-- 	lazygit:toggle()
	-- end
	--
	-- local wk = require('which-key')
	--
	-- wk.register({ ['<leader>z'] = { '<cmd>lua _lazygit_toggle()<CR>', 'Lazygit' } })
end

return function(use)
	use({
		'akinsho/nvim-toggleterm.lua',
		config = run,
	})
end
