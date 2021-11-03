return function(use)
	if vim.fn.exepath('gopls') ~= '' then
		use({
			'ray-x/go.nvim',
			config = function()
				require('go').setup({
					max_line_len = 120, -- max line length in goline format
					tag_transform = false, -- tag_transfer  check gomodifytags for details
					verbose = false, -- output loginf in messages
					lsp_cfg = false, -- true: apply go.nvim non-default gopls setup
					lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
					lsp_on_attach = require('lsp.on_attach'),
					lsp_diag_hdlr = true, -- hook lsp diag handler
					dap_debug = false, -- set to true to enable dap
					dap_debug_keymap = true, -- set keymaps for debugger
					dap_debug_gui = true, -- set to true to enable dap gui, highly recommand
					dap_debug_vt = true, -- set to true to enable dap virtual text
				})
			end,
			ft = { 'go' },
		})
	end
end
