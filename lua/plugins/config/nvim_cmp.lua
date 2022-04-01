local function cmp_config()
	local cmp = require('cmp')
	cmp.setup({
		mapping = {
			['<C-p>'] = cmp.mapping.select_prev_item(),
			['<C-n>'] = cmp.mapping.select_next_item(),
			['<C-d>'] = cmp.mapping.scroll_docs(-4),
			['<C-u>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			['<C-y>'] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
		},
		snippet = {
			expand = function(args)
				require('luasnip').lsp_expand(args.body)
			end,
		},
		formatting = {
			format = require('lspkind').cmp_format({
				mode = 'symbol_text',
				preset = 'codicons',
			}),
		},
		sources = {
			{ name = 'luasnip' },
			{ name = 'path' },
			{ name = 'nvim_lsp' },
			{ name = 'buffer' },
			{ name = 'rg' },
			{ name = 'spell' },
			{ name = 'emoji' },
		},
		preselect = cmp.PreselectMode.Item,
	})

	local npairs = require('nvim-autopairs')

	npairs.setup({
		disable_filetype = { 'TelescopePrompt' },
		check_ts = true,
		map_cr = true,
	})

	local wk = require('which-key')

	local ls = require('luasnip')
	ls.config.set_config({
		history = true,
		update_events = 'TextChanged,TextChangedI',
		delete_check_events = 'TextChanged',
		enable_autosnippets = true,
	})
	local mappings = {
		['<c-j>'] = {
			function()
				local ok, neogen = pcall(require, 'neogen')
				if ok and neogen.jumpable() then
					neogen.jump_next()
					return
				end
				ls.expand_or_jump()
			end,
			'(Snippet) Expand Snippet or Jump to Next Placeholder',
		},
		['<c-k>'] = {
			function()
				local ok, neogen = pcall(require, 'neogen')
				if ok and neogen.jumpable(-1) then
					neogen.jump_prev()
					return
				end
				ls.jump(-1)
			end,
			'(Snippet) Jump to Previous Placeholder',
		},
		['<c-l>'] = {
			function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end,
			'(Snippet) Next Choice',
		},
		['<c-h>'] = {
			function()
				if ls.choice_active() then
					ls.change_choice(-1)
				end
			end,
			'(Snippet) Prev Choice',
		},
	}
	wk.register({
		['<leader>qs'] = {
			function()
				local dir = [[$HOME/.config/nvim/lua/snippets/luasnip/]]
				local files = io.popen(string.format([[ls -a "%s"]], dir))
				local filenames = {}
				for filename in files:lines() do
					table.insert(filenames, filename)
				end
				for i, filename in ipairs(filenames) do
					if i ~= 1 and i ~= 2 then
						local str = string.format([[source "%s%s"]], dir, filename)
						vim.cmd(str)
					end
				end
				vim.notify('Snippet reloaded', 'info', { title = 'System' })
			end,
			'(Snippet) Reload',
		},
	})
	wk.register(mappings, { mode = 'i' })
	wk.register(mappings, { mode = 's' })

	require('snippets.luasnip')
end

return function(use)
	use({
		'hrsh7th/nvim-cmp',
		requires = {
			'L3MON4D3/LuaSnip',
			'f3fora/cmp-spell',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-emoji',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-path',
			'lukas-reineke/cmp-rg',
			'hrsh7th/cmp-nvim-lsp-signature-help',
			'onsails/lspkind-nvim',
			'rafamadriz/friendly-snippets',
			'saadparwaiz1/cmp_luasnip',
			'windwp/nvim-autopairs',
			'mortepau/codicons.nvim',
		},
		wants = { 'which-key.nvim' },
		config = cmp_config,
	})
end
