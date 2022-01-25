local function cmp_config()
	require('lspkind').init({
		with_text = true,
		preset = 'default',
		symbol_map = { Field = '' },
	})

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
			format = function(entry, vim_item)
				vim_item.kind = (require('lspkind').presets.default[vim_item.kind] or ' ') .. ' ' .. vim_item.kind
				-- set a name for each source
				vim_item.menu = ({
					buffer = '[Buffer]',
					nvim_lsp = '[LSP]',
					luasnip = '[LuaSnip]',
					nvim_lua = '[Lua]',
					latex_symbols = '[Latex]',
					path = '[Path]',
					vsnip = '[VSnip]',
				})[entry.source.name]
				return vim_item
			end,
		},
		sources = {
			{ name = 'nvim_lsp' },
			{ name = 'path' },
			{ name = 'buffer' },
			{ name = 'spell' },
			{ name = 'emoji' },
			{ name = 'luasnip' },
		},
	})

	local npairs = require('nvim-autopairs')

	npairs.setup({
		disable_filetype = { 'TelescopePrompt' },
		check_ts = true,
		map_cr = true,
	})

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
			'hrsh7th/cmp-nvim-lsp-signature-help',
			'onsails/lspkind-nvim',
			'rafamadriz/friendly-snippets',
			'saadparwaiz1/cmp_luasnip',
			'windwp/nvim-autopairs',
		},
		wants = { 'which-key.nvim' },
		config = cmp_config,
	})
end
