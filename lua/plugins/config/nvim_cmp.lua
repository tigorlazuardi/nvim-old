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
			{ name = 'nvim_lsp' },
			{ name = 'path' },
			{ name = 'buffer' },
			{ name = 'spell' },
			{ name = 'emoji' },
			{ name = 'luasnip' },
			{ name = 'rg' },
		},
	})

	-- local npairs = require('nvim-autopairs')
	--
	-- npairs.setup({
	-- 	disable_filetype = { 'TelescopePrompt' },
	-- 	check_ts = true,
	-- 	map_cr = true,
	-- })

	local wk = require('which-key')

	local luasnip = require('luasnip')
	local mappings = {
		['<c-j>'] = {
			function()
				local ok, neogen = pcall(require, 'neogen')
				if not ok then
					luasnip.expand_or_jump()
				end
				if neogen.jumpable() then
					neogen.jump_next()
					return
				end
				luasnip.expand_or_jump()
			end,
			'(Snippet) Expand Snippet or Jump to Next Placeholder',
		},
		['<c-k>'] = {
			function()
				local ok, neogen = pcall(require, 'neogen')
				if not ok then
					luasnip.jump(-1)
				end
				if neogen.jumpable(-1) then
					neogen.jump_prev()
					return
				end
				luasnip.jump(-1)
			end,
			'(Snippet) Jump to Previous Placeholder',
		},
	}
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
			-- 'windwp/nvim-autopairs',
			'mortepau/codicons.nvim',
		},
		wants = { 'which-key.nvim' },
		config = cmp_config,
	})
end
