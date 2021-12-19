return function(use)
	use({
		'ms-jpq/coq_nvim',
		branch = 'coq',
		run = ':COQdeps',
		event = 'BufEnter',
		requires = {
			{ 'ms-jpq/coq.artifacts', branch = 'artifacts' },
			{
				'ms-jpq/coq.thirdparty',
				branch = '3p',
			},
			{ 'windwp/nvim-autopairs' },
		},
		setup = function()
			vim.g.coq_settings = { keymap = { recommended = false }, auto_start = true }
		end,
		config = function()
			local packer = require('packer')

			-- trigger coq side-effects
			packer.loader('coq.thirdparty')
			packer.loader('coq_nvim')
			packer.loader('coq.artifacts')
			require('coq')

			-- Nvim Autopairs configuration
			packer.loader('nvim-autopairs')
			local remap = vim.api.nvim_set_keymap
			local npairs = require('nvim-autopairs')

			npairs.setup({ map_bs = false, map_cr = false, check_ts = true, disable_filetype = { 'TelescopePrompt' } })

			local remap_opts = { expr = true, noremap = true }
			remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], remap_opts)
			remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], remap_opts)
			remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], remap_opts)
			remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<s-tab>"]], remap_opts)

			_G.MUtils = {}

			_G.MUtils.CR = function()
				if vim.fn.pumvisible() ~= 0 then
					if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
						return npairs.esc('<c-y>')
					else
						return npairs.esc('<c-e>') .. npairs.autopairs_cr()
					end
				else
					return npairs.autopairs_cr()
				end
			end
			remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

			_G.MUtils.BS = function()
				if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
					return npairs.esc('<c-e>') .. npairs.autopairs_bs()
				else
					return npairs.autopairs_bs()
				end
			end
			remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })
		end,
	})
end
