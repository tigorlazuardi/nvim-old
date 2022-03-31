local ls = require('luasnip')
local s = ls.snippet
local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
local d = ls.dynamic_node
-- local events = require('luasnip.util.events')
local fmta = require('luasnip.extras.fmt').fmta

local ts_utils = require('nvim-treesitter.ts_utils')
local ts_locals = require('nvim-treesitter.locals')

function is_in_function() --{{{
	local current_node = ts_utils.get_node_at_cursor()
	if not current_node then
		return false
	end
	local expr = current_node

	while expr do
		if expr:type() == 'function_declaration' or expr:type() == 'method_declaration' then
			return true
		end
		expr = expr:parent()
	end
	return false
end --}}}

function not_in_function()
	return not is_in_function()
end

local not_in_func = {
	show_condition = not_in_function,
	condition = not_in_function,
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
	t({ 'map[' }),
	i(1, 'key'),
	t({ ']' }),
	i(2, 'value'),
	i(0),
})

local map_key_type_auto = s({ trig = 'map[', name = 'auto-map', dscr = 'quick map' }, {
	t('map['),
	i(1, 'key'),
	t(']'),
	i(2, 'type'),
	i(0),
})

local main = s(
	{ trig = 'main', name = 'Main', dscr = 'Create a main function' },
	sn(1, fmta('func main() {\n\t<>\n}', i(1))),
	not_in_func
)

ls.add_snippets('go', { apm_span, map_string_interface, map_string_interface_insert, map_key_type, main })
ls.add_snippets('go', { map_string_interface_insert_regex, apm_span, map_key_type_auto }, { type = 'autosnippets' })
