local luasnip = require("luasnip")
local js_snippets = require("snippets/javascript")
local ts_snippets = require("snippets/typescript")
local react_snippets = require("snippets/react")
local css_snippets = require("snippets/css")
local html_snippets = require("snippets/html")
local lua_snippets = require("snippets/lua")
local gitcommit_snippets = require("snippets/gitcommit")

luasnip.add_snippets("all", require("snippets/all"))

luasnip.add_snippets("typescript", js_snippets)
luasnip.add_snippets("typescript", ts_snippets)
luasnip.add_snippets("javascript", js_snippets)

luasnip.add_snippets("javascriptreact", react_snippets)
luasnip.add_snippets("typescriptreact", react_snippets)
luasnip.filetype_extend("typescriptreact", { "typescript" })
luasnip.filetype_extend("javascriptreact", { "javascript" })

luasnip.add_snippets("css", css_snippets)

luasnip.add_snippets("astro", css_snippets)
luasnip.add_snippets("astro", js_snippets)
luasnip.add_snippets("astro", html_snippets)

luasnip.add_snippets("html", html_snippets)
luasnip.add_snippets("lua", lua_snippets)

luasnip.add_snippets("gitcommit", gitcommit_snippets)
