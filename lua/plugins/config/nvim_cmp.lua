local function cmp_config()
	local prequire = require('personal.utils.prequire')
	local packer = prequire('packer')
	if not packer then
		return
	end
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
			-- ['<CR>'] = cmp.mapping.confirm({ select = true }),
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

	-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
	-- cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))

	local wk = require('which-key')

	wk.register({
		['<c-j>'] = { '<Plug>luasnip-expand-or-jump', '(Snippet) Expand Snippet or Jump to Next Placeholder' },
		['<c-k>'] = { '<Plug>luasnip-jump-prev', '(Snippet) Jump to Previous Placeholder' },
	}, {
		mode = 'i',
	})

	wk.register({
		['<c-j>'] = {
			'<Plug>luasnip-expand-or-jump',
			'(Snippet) Expand Snippet or Jump to Next Placeholder',
		},
		['<c-k>'] = { '<Plug>luasnip-jump-prev', '(Snippet) Jump to Previous Placeholder' },
	}, {
		mode = 's',
	})

	require('snippets.luasnip')

	-- vim.cmd([[
	-- 	" gray
	-- 	highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
	-- 	" blue
	-- 	highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
	-- 	highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
	-- 	" light blue
	-- 	highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
	-- 	highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
	-- 	highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
	-- 	" pink
	-- 	highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
	-- 	highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
	-- 	" front
	-- 	highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
	-- 	highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
	-- 	highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
	-- ]])
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
