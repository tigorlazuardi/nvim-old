local ls = require('luasnip')

local table_regex = ls.s({
	trig = 'tab(%d)(%d)',
	name = 'Dynamic Table Creation by (col)x(row)',
	dscr = [[Creates table dynamically. With maximum of 9 (col) x 9 (row) table]],
	regTrig = true,
}, {
	ls.d(1, function(_, snip)
		local col, row = tonumber(snip.captures[1]) or 0, tonumber(snip.captures[2]) or 0
		if row == 0 or col == 0 then
			vim.notify('cannot create table with 0 column or rows', 'error', { title = 'Snippet Error' })
			return ls.sn(nil, {})
		end

		local nodes = {}
		local node_idx = 0

		local header = {}

		table.insert(header, ls.t('| '))
		for _ = 1, col do
			node_idx = node_idx + 1
			table.insert(header, ls.i(node_idx, 'Header'))
			table.insert(header, ls.t(' | '))
		end

		--- add new line
		table.insert(header, ls.t({ '', '' }))

		local justifies = {}
		table.insert(justifies, ls.t('| '))
		for _ = 1, col do
			node_idx = node_idx + 1
			table.insert(
				justifies,
				ls.c(node_idx, {
					ls.t(':--- ', {
						node_ext_opts = { active = { virt_text = { { '> Justify Left' } } } },
					}),
					ls.t(':---:', {
						node_ext_opts = { active = { virt_text = { { '> Justify Center' } } } },
					}),
					ls.t(' ---:', {
						node_ext_opts = { active = { virt_text = { { '> Justify Right' } } } },
					}),
				})
			)
			table.insert(justifies, ls.t(' | '))
		end
		table.insert(justifies, ls.t({ '', '' }))

		local body = {}
		for _ = 1, row do
			table.insert(body, ls.t('| '))
			for _ = 1, col do
				node_idx = node_idx + 1
				table.insert(body, ls.i(node_idx, 'text'))
				table.insert(body, ls.t(' | '))
			end
			table.insert(body, ls.t({ '', '' }))
		end
		table.insert(body, ls.t({ '', '' }))

		nodes = vim.list_extend(nodes, header)
		nodes = vim.list_extend(nodes, justifies)
		nodes = vim.list_extend(nodes, body)
		return ls.sn(nil, nodes)
	end),
})

ls.add_snippets('markdown', {
	table_regex,
}, { type = 'autosnippets' })

local tab_dscr = [[Creates table dynamically. With maximum of 9 (col) x 9 (row) table.

To actually use it type "tbl(n)(n)" literally, change (n)(n) to numbers e.g. "tab23"
to create 2 (col) x 3 (row) table.

This snippet does nothing.]]
ls.add_snippets('markdown', {
	ls.s({
		trig = 'tab',
		name = 'Dynamic Table Creation by (col)x(row)',
		dscr = tab_dscr,
	}, {}),
})
