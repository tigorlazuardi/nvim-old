local ls = require('luasnip')
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local events = require('luasnip.util.events')

local apm_span = s({ trig = 'apm:span', name = 'apm span', dscr = 'creates apm span from context' }, {
	t({ [[span, ctx := apm.StartSpan(ctx, "]] }),
	i(1, 'function_name'),
	t({ [[", "]] }),
	i(2, 'type_name'),
	t({ '")', 'defer span.End()' }),
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

local map_key_value = s({ trig = 'map', name = 'map[<key>]<value>', dscr = 'map short hand' }, {
	t({ 'map[' }),
	i(1, 'key'),
	t({ ']' }),
	i(2, 'value'),
	i(0),
})

ls.add_snippets('go', { apm_span, map_string_interface, map_string_interface_insert, map_key_value })
ls.add_snippets('go', { apm_span, map_string_interface_insert_regex }, { type = 'autosnippets' })
