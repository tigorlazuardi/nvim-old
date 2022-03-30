local ls = require('luasnip')
local fmta = require('luasnip.extras.fmt').fmta

local quick_pack = ls.s(
	{ trig = 'qp', name = 'New Packer Module', dscr = 'Creates a blank packer module' },
	fmta(
		[[
		return function(use)
			use({
				'<>',
				config = function()
					<>
				end,
			})
		end
		]],
		{
			ls.i(1, 'github_repo'),
			ls.i(2),
		}
	)
)

ls.add_snippets('lua', {
	quick_pack,
})
