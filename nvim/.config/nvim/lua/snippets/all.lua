local luasnip = require("luasnip")
local snippet = luasnip.s
local u = require("snippets/utils")
local partial = require("luasnip.extras").partial

return {
  snippet("time", partial(vim.fn.strftime, "%H:%M:%S")),
  snippet("date", partial(vim.fn.strftime, "%d.%m.%Y")),

  -- auto pairs
  snippet("{ | }", u.define_pair("{ ", " }")),
  snippet("({ | })", u.define_pair("({ ", " })")),
  snippet("${|}", u.define_pair("${", "}")),
  snippet("<|>", u.define_pair("<", ">")),
  snippet("<| />", u.define_pair("<", " />")),
  snippet("(|)", u.define_pair("(", ")")),
  snippet("[|]", u.define_pair("[", "]")),
  snippet('"|"', u.define_pair('"', '"')),
  snippet("'|'", u.define_pair("'", "'")),
  snippet("`|`", u.define_pair("`", "`")),
}
