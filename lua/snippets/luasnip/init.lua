local ls = require('luasnip')
local go = require('snippets.luasnip.go')

ls.snippets = {
	go = go,
}

require('luasnip/loaders/from_vscode').lazy_load()
