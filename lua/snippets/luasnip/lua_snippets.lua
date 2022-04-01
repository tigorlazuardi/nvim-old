local ls = require('luasnip')
local fmta = require('luasnip.extras.fmt').fmta
local rep = require('luasnip.extras').rep

local s = ls.snippet
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node

local packmod = s(
	{ trig = 'packmod', name = 'New Packer Module', dscr = 'Creates a blank packer module' },
	fmta(
		[[
		return function(use)
			use({
				'<repo>',
				<config>
			})
		end
		]],
		{
			repo = i(1, 'repo'),
			config = isn(
				2,
				c(1, {
					fmta('config = function ()\n\t<body>\nend,', { body = i(1) }),
					t(''),
				}),
				'$PARENT_INDENT\t\t'
			),
		}
	)
)

local prequire = s(
	{ trig = 'preq', name = 'Protected Require', dscr = 'Protected call' },
	fmta(
		[[
	local <ok1>, <mod> = pcall(require, "<target>")
	if not <ok2> then
		<ret>
	end
	<e>
	]],
		{
			ok1 = i(1, 'ok'),
			mod = ls.f(function(arg)
				local content = arg[1][1]
				local str = vim.split(content, '.', true)
				local last = str[#str] or ''
				last = last:gsub('-', '_')
				return last
			end, { 2 }),
			ok2 = rep(1),
			target = i(2, 'target'),
			ret = i(3, 'return'),
			e = i(0),
		}
	)
)

local req = s(
	{ trig = 'req', name = 'require module', dscr = 'require module' },
	fmta(
		[[
		local <> = require('<>')
		<>
		]],
		{
			ls.f(function(arg)
				local content = arg[1][1]
				local str = vim.split(content, '.', true)
				local last = str[#str] or ''
				last = last:gsub('-', '_')
				return last
			end, { 1 }),
			i(1, 'target'),
			i(0),
		}
	)
)

local m_snip = s(
	{ trig = 'lm', name = 'local M', dscr = 'local M' },
	fmta(
		[[
	local M = {}
	
	<>

	return M
	]],
		{ i(0) }
	)
)

local meth = s(
	{ trig = 'meth', name = 'Method', dscr = 'Method declaration' },
	fmta(
		[[
	function <receiver>.<name>(<params>)
		<e>
	end
	]],
		{
			receiver = i(1, 'receiver'),
			name = i(2, 'name'),
			params = i(3),
			e = i(0),
		}
	)
)

local local_f = s(
	{ trig = 'lf', name = 'local function', dscr = 'local function declaration' },
	fmta(
		[[
		---<>
		local function <>(<>)
			<>
		end
	]],
		{ i(3), i(1, 'name'), i(2), i(0) }
	)
)

local local_t = s(
	{ trig = 'lt', name = 'local table', dscr = 'declare new table' },
	fmta(
		[[
		local <> = {<>}
		]],
		{ i(1, 'name'), i(0) }
	)
)

local todo = s({ trig = 'todo', name = 'Todo Note', dscr = 'create a todo comment' }, {
	c(1, {
		ls.sn(nil, fmta('-- TODO: <>', { i(1) })),
		ls.sn(nil, fmta('-- TODO(<>): <>', { i(1, 'person'), i(2) })),
	}),
})

ls.add_snippets('lua', {
	packmod,
	prequire,
	m_snip,
	meth,
	local_f,
	local_t,
	todo,
	req,
})
