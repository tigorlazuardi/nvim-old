local ls = require('luasnip')
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local util = require('snippets.luasnip.go_utils')
local rep = require('luasnip.extras').rep

local ts_utils = require('nvim-treesitter.ts_utils')
local ts_locals = require('nvim-treesitter.locals')

function not_in_function()
	return not util.is_in_function()
end

local not_in_func = {
	show_condition = not_in_function,
	condition = not_in_function,
}

local in_func = {
	show_condition = util.is_in_function,
	condition = util.is_in_function,
}

local apm_span = s({ trig = 'apm:span', name = 'apm span', dscr = 'creates apm span from context' }, {
	d(1, function(_args, _snip)
		local cursor_node = ts_utils.get_node_at_cursor()
		local scope_tree = ts_locals.get_scope_tree(cursor_node, 0)
		local fn_node
		for _, scope in ipairs(scope_tree) do
			if scope:type() == 'function_declaration' or scope:type() == 'method_declaration' then
				fn_node = scope
				break
			end
		end
		if not fn_node then
			vim.notify('snippet requires cursor inside a function or method', 'error', { title = 'Snippet Error' })
			return sn(nil, {})
		end

		local name, span_type
		local fn_name_node = fn_node:field('name')[1]
		name = ts_utils.get_node_text(fn_name_node)[1]
		if fn_node:type() == 'function_declaration' then
			span_type = name
		else
			local fn_receiver_node = fn_node:field('receiver')[1]:child(1)
			local fn_receiver_type_node = fn_receiver_node:field('type')[1]
			if fn_receiver_type_node:type() == 'pointer_type' then
				fn_receiver_type_node = fn_receiver_type_node:child(1)
			end
			span_type = ts_utils.get_node_text(fn_receiver_type_node)[1]
		end
		return sn(
			nil,
			fmta(
				[[
				span, ctx := apm.StartSpan(ctx, "<name>", "<span_type>")
				defer span.End()
				]],
				{ name = i(1, name), span_type = i(2, span_type) }
			)
		)
	end),
	i(0),
})

local map_string_interface = s(
	{ trig = 'msi', name = 'map[string]interface{}', dscr = 'map string interface definition shorthand' },
	{
		t({ 'map[string]interface{}' }),
		i(0),
	}
)

local map_string_interface_insert = s(
	{ trig = 'msi', name = 'map[string]interface{}{}', dscr = 'map string interface with insert' },
	{
		t({ 'map[string]interface{}{', '"' }),
		i(1, 'key'),
		t({ '":' }),
		i(2, 'value'),
		t({ ',', '}' }),
		i(0),
	}
)

local map_string_interface_insert_regex = s({
	trig = 'msi(%d)',
	name = 'dynamic map[string]interface{} generation',
	dscr = 'map string interface with insert regex',
	regTrig = true,
}, {
	d(1, function(_args, snip)
		local count = tonumber(snip.captures[1]) or 0
		if count == 0 then
			return sn(nil, { t('map[string]interface{}{}') })
		end
		local nodes = { t({ 'map[string]interface{}{', '' }) }

		local nodeIdx = 0
		for idx = 1, count do
			nodeIdx = nodeIdx + 1
			table.insert(nodes, t('\t"'))
			table.insert(nodes, i(nodeIdx, string.format('key%d', idx)))
			table.insert(nodes, t('": '))
			nodeIdx = nodeIdx + 1
			table.insert(nodes, i(nodeIdx, string.format('value%d', idx)))
			table.insert(nodes, t({ ',', '' }))
		end

		table.insert(nodes, t('}'))
		return sn(nil, nodes)
	end),
	i(0),
})

local map_key_type = s({ trig = 'map', name = 'map[<key>]<value>', dscr = 'map short hand' }, {
	sn(1, fmta('map[<key>]<type>', { key = i(1, 'key'), type = i(2, 'type') })),
})

local map_key_type_auto = s({ trig = 'map[', name = 'auto-map', dscr = 'quick map' }, {
	sn(1, fmta('map[<key>]<type>', { key = i(1, 'key'), type = i(2, 'type') })),
})

local main = s(
	{ trig = 'main', name = 'Main', dscr = 'Create a main function' },
	sn(1, fmta('func main() {\n\t<>\n}', i(1))),
	not_in_func
)

local if_err = ls.s(
	{ trig = 'ife', name = 'If error', dscr = 'If error, return wrapped' },
	fmt('if {} != nil {{\n\treturn {}\n}}\n{}', {
		ls.i(1, 'err'),
		ls.d(2, util.make_return_nodes, { 1 }),
		ls.i(0),
	}),
	in_func
)

local if_call = ls.s(
	{ trig = 'ifcall', name = 'IF CALL', dscr = 'Call a function and check the error' },
	fmta(
		[[
		<>, <> := <>(<>)
		if <> != nil {
			return <>
		}
		<>
		]],
		{
			ls.i(1, { 'val' }),
			ls.i(2, { 'err' }),
			ls.i(3, { 'Func' }),
			ls.i(4),
			rep(2),
			ls.d(5, util.make_return_nodes, { 2 }),
			ls.i(0),
		}
	),
	in_func
)

local make = ls.s(
	{ trig = 'make', name = 'Make', dscr = 'Allocate map or slice' },
	fmt('{} {}= make({})\n{}', {
		ls.i(1, 'name'),
		ls.i(2),
		ls.c(3, {
			fmt('[]{}, {}', { ls.i(1, 'type'), ls.i(2, 'len') }),
			fmt('[]{}, 0, {}', { ls.i(1, 'type'), ls.i(2, 'len') }),
			fmt('map[{}]{}, {}', { ls.i(1, 'keys'), ls.i(2, 'values'), ls.i(3, 'len') }),
		}),
		ls.i(0),
	}),
	in_func
)

ls.add_snippets('go', {
	apm_span,
	map_string_interface,
	map_string_interface_insert,
	map_key_type,
	main,
	if_err,
	make,
	if_call,
})
ls.add_snippets('go', {
	map_string_interface_insert_regex,
	map_key_type_auto,
}, { type = 'autosnippets' })
