local luasnip = require('luasnip')
local s = luasnip.snippet
local sn = luasnip.snippet_node
local d = luasnip.dynamic_node
local t = luasnip.text_node
local i = luasnip.insert_node
local f = luasnip.function_node
local fmta = require('luasnip.extras.fmt').fmta
local c = luasnip.choice_node
local util = require('snippets.luasnip.rust_utils')

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

---comment
---@param pub boolean
---@return table
local fn_snip = function(pub, opts)
	return fmta(
		[[
		/// <desc>
		<prefix>fn <name>(<param>)<arrow><ret><space>{
			<e>
		}
		]],
		{
			prefix = f(function()
				if pub then
					return 'pub '
				end
				return ''
			end),
			name = i(1, 'name'),
			desc = i(2, 'description'),
			param = i(3),
			arrow = f(function(arg)
				if arg[1][1] ~= '' then
					return ' -> '
				end
				return ' '
			end, { 4 }),
			ret = i(4),
			space = f(function(arg)
				if arg[1][1] ~= '' then
					return ' '
				end
				return ''
			end, { 4 }),
			e = i(5),
		},
		opts
	)
end

local fn = s({ trig = 'fn', name = 'function declaration', dscr = 'create a new function declaration' }, {
	c(1, {
		sn(nil, fn_snip(false)),
		sn(nil, fn_snip(true)),
	}),
}, not_in_func)

luasnip.add_snippets('rust', { fn })
