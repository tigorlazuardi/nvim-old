local ls = require('luasnip')
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local c = ls.choice_node
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

---Creates responder_if_err node
local function responder_if_err(trig)
	return ls.s(
		{ trig = trig, name = 'Responder if err', dscr = 'If error, return error wrapped in responder' },
		fmta('if <> != nil {\n\treturn <>\n}\n<>', {
			ls.i(1, 'err'),
			ls.d(2, util.make_return_nodes_responder, { 1 }),
			ls.i(0),
		}),
		in_func
	)
end

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
	{ trig = 'make', name = 'Make Alloc', dscr = 'Allocate map or slice' },
	fmt('{} {}= make({})\n{}', {
		ls.i(1, 'name'),
		ls.i(2),
		ls.c(3, {
			fmt('[]{}, {}', { ls.i(1, 'type'), ls.i(2, 'cap') }, {
				node_ext_opts = { active = { virt_text = { { 'Slice filled with zero value until capacity' } } } },
			}),
			fmt('[]{}, 0, {}', { ls.i(1, 'type'), ls.i(2, 'cap') }, {
				node_ext_opts = { active = { virt_text = { { 'Empty slice with custom capacity' } } } },
			}),
			fmt('map[{}]{}, {}', { ls.i(1, 'key'), ls.i(2, 'value'), ls.i(3, 'cap') }, {
				node_ext_opts = { active = { virt_text = { { 'Map with custom capacity' } } } },
			}),
		}),
		ls.i(0),
	}),
	in_func
)

---recursive choice or more fields
local function dynamic_msi()
	return sn(nil, {
		t([["]]),
		i(1, 'key'),
		t([[": ]]),
		i(2, 'value'),
		t(','),
		c(3, {
			t('', {
				node_ext_opts = { active = { virt_text = { { 'Select next choice to insert more lines' } } } },
			}),
			sn(1, {
				t({ '', '\t' }),
				d(1, dynamic_msi),
			}),
		}),
	})
end

local dynamic_map = s({ trig = 'map', dscr = 'Dynamic mapping', name = 'dynamic map' }, {
	c(1, {
		sn(
			nil,
			fmta(
				[[
			map[string]interface{}{<>
				<>
			}]],
				{
					i(1),
					d(2, dynamic_msi),
				}
			)
		),
		sn(nil, fmta([[map[string]interface{}<>]], { i(1) })),
		sn(nil, fmta([[map[<>]<>]], { i(1, 'key'), i(2, 'type') })),
	}),
})

ls.add_snippets('go', {
	apm_span,
	dynamic_map,
	main,
	if_err,
	make,
	if_call,
	responder_if_err('resp'),
	responder_if_err('respif'),
	responder_if_err('ifr'),
})
