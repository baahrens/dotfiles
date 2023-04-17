require("luasnip").add_snippets(nil, {
	all = {
		unpack(require("snippets/all")),
	},
	javascriptreact = {
		unpack(require("snippets/javascript")),
		unpack(require("snippets/react")),
	},
	typescriptreact = {
		unpack(require("snippets/javascript")),
		unpack(require("snippets/react")),
	},
})
