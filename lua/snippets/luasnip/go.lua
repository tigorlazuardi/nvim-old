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
	d(1, function(_args, _snip)
		local def = get_func_or_method_declaration_on_cursor()
		if def == nil then
			vim.notify('apm:span snippet is not run inside a function or method', 'error')
			return sn(nil, {})
		end
		local name, span_type
		name = def.func.name
		if def.receiver.struct_name == '' then
			span_type = def.func.name
		else
			span_type = def.receiver.struct_name
		end

		return sn(nil, {
			t({ [[span, ctx := apm.StartSpan(ctx, "]] }),
			i(1, name),
			t({ [[", "]] }),
			i(2, span_type),
			t({ '")', 'defer span.End()' }),
		})
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

local map_key_value = s({ trig = 'map', name = 'map[<key>]<value>', dscr = 'map short hand' }, {
	t({ 'map[' }),
	i(1, 'key'),
	t({ ']' }),
	i(2, 'value'),
	i(0),
})

ls.add_snippets('go', { apm_span, map_string_interface, map_string_interface_insert, map_key_value })
ls.add_snippets('go', { map_string_interface_insert_regex, apm_span }, { type = 'autosnippets' })

----- Treesitter snippets helper

local q = require('vim.treesitter.query')

local ts_query_method = [[
((method_declaration
	receiver: (parameter_list
		(parameter_declaration
			type: (type_identifier) @receiver.type))
	name: (field_identifier) @method.name
) @method.body (#offset! @method.body)) 
]]

local ts_query_method_pointer = [[
((method_declaration
	receiver: (parameter_list
		(parameter_declaration
			type: (pointer_type (type_identifier) @method.type) @method.type.pointer))
 	name: (field_identifier) @method.name
) @method.body (#offset! @method.body))
]]

local ts_query_function = [[
((function_declaration
	name: (identifier) @func.name
) @full.func (#offset! @full.func))
]]

local function pos_inside_metadata(row, metadata)
	if metadata == nil then
		return false
	end
	local m = metadata.content[1]
	if m == nil then
		return false
	end
	local rowStart, _, rowEnd, _ = unpack(m)
	rowStart = tonumber(rowStart)
	rowEnd = tonumber(rowEnd)
	return row >= rowStart and row <= rowEnd
end

function get_func_or_method_declaration_on_cursor()
	if vim.bo.filetype ~= 'go' then
		return
	end
	local bufnr = vim.api.nvim_get_current_buf()
	local lang_tree = vim.treesitter.get_parser(bufnr, 'go')
	local syntax_tree = lang_tree:parse()
	local r = syntax_tree[1]
	local root = r:root()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	row, col = row - 1, col

	local cursor = vim.treesitter.parse_query('go', ts_query_method)

	for _, captures, metadata in cursor:iter_matches(root, bufnr) do
		if pos_inside_metadata(row, metadata) then
			return {
				receiver = {
					type = q.get_node_text(captures[1], bufnr),
					struct_name = q.get_node_text(captures[1], bufnr),
				},
				func = {
					name = q.get_node_text(captures[2], bufnr),
				},
			}
		end
	end

	cursor = vim.treesitter.parse_query('go', ts_query_method_pointer)

	for _, captures, metadata in cursor:iter_matches(root, bufnr) do
		if pos_inside_metadata(row, metadata) then
			return {
				receiver = {
					type = q.get_node_text(captures[2], bufnr),
					struct_name = q.get_node_text(captures[1], bufnr),
				},
				func = {
					name = q.get_node_text(captures[3], bufnr),
				},
			}
		end
	end

	cursor = vim.treesitter.parse_query('go', ts_query_function)

	for _, captures, metadata in cursor:iter_matches(root, bufnr) do
		if pos_inside_metadata(row, metadata) then
			return {
				receiver = {
					type = '',
					struct_name = '',
				},
				func = {
					name = q.get_node_text(captures[3], bufnr),
				},
			}
		end
	end

	return nil
end
