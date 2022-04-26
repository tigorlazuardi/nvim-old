local function cmp_config()
	local cmp = require('cmp')

	local compare = require('cmp.config.compare')
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
				menu = {
					buffer = '[Buffer]',
					nvim_lsp = '[LSP]',
					nvim_lua = '[API]',
					path = '[Path]',
					luasnip = '[Luasnip]',
					rg = '[Rip Grep]',
					spell = '[Spell]',
					copilot = '[Copilot]',
					emoji = '[Emoji]',
				},
			}),
		},
		sources = {
			{ name = 'copilot', priority = 8 },
			{ name = 'nvim_lua', priority = 8 },
			{ name = 'nvim_lsp', priority = 8 },
			{ name = 'luasnip', priority = 7 },
			{ name = 'buffer', priority = 7, max_item_count = 3, keyword_length = 5 },
			{ name = 'path', priority = 6 },
			{ name = 'rg', priority = 5, max_item_count = 5, keyword_length = 5 },
			{ name = 'spell', priority = 4, max_item_count = 5, keyword_length = 5 },
			{ name = 'emoji', priority = 3 },
		},
		preselect = cmp.PreselectMode.None,
		sorting = {
			priority_weight = 1.0,
			comparators = {
				compare.locality,
				compare.recently_used,
				compare.score,
				compare.offset,
				compare.order,
			},
		},
	})
	cmp.setup.cmdline(':', {
		sources = cmp.config.sources({
			{ name = 'path' },
		}, {
			{ name = 'cmdline' },
		}),
	})

	local npairs = require('nvim-autopairs')

	npairs.setup({
		disable_filetype = { 'TelescopePrompt' },
		check_ts = true,
		map_cr = true,
	})

	local wk = require('which-key')

	local ls = require('luasnip')
	local types = require('luasnip.util.types')
	ls.config.set_config({
		history = true,
		update_events = 'TextChanged,TextChangedI',
		delete_check_events = 'TextChanged',
		enable_autosnippets = false,
		ext_opts = {
			[types.choiceNode] = {
				active = {
					virt_text = { { '<- Choice' } },
				},
			},
		},
	})

	local mappings = {
		['<c-j>'] = {
			function()
				ls.expand_or_jump()
			end,
			'(Snippet) Expand Snippet or Jump to Next Placeholder',
		},
		['<c-k>'] = {
			function()
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
			'hrsh7th/cmp-nvim-lua',
			'lukas-reineke/cmp-rg',
			'hrsh7th/cmp-nvim-lsp-signature-help',
			'onsails/lspkind-nvim',
			'rafamadriz/friendly-snippets',
			'saadparwaiz1/cmp_luasnip',
			'windwp/nvim-autopairs',
			'mortepau/codicons.nvim',
			'hrsh7th/cmp-cmdline',
		},
		wants = { 'which-key.nvim' },
		config = cmp_config,
	})

	-- Required for registering token to github
	use({
		'github/copilot.vim',
		disable = vim.fn.filereadable(vim.fn.expand('$HOME/.config/github-copilot/hosts.json')) == 1,
	})

	-- copilot
	use({
		'zbirenbaum/copilot.lua',
		event = 'InsertEnter',
		config = function()
			vim.schedule(function()
				require('copilot').setup()
			end)
		end,
	})

	use({
		'zbirenbaum/copilot-cmp',
		after = { 'copilot.lua', 'nvim-cmp' },
	})
end
