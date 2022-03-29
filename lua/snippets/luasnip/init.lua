local ls = require('luasnip')
local go = require('snippets.luasnip.go')

ls.add_snippets('go', go)

require('luasnip/loaders/from_vscode').lazy_load()
