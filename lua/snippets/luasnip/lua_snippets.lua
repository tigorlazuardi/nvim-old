local ls = require('luasnip')
local fmta = require('luasnip.extras.fmt').fmta

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

ls.add_snippets('lua', {
	packmod,
	s('isn2', {
		isn(1, ls.t({ 'This is', 'A multiline', 'comment' }), '$PARENT_INDENT\t'),
	}),
})
