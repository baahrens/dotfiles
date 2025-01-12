local ls = require("luasnip")
local text = ls.text_node
local snippet = ls.s
local u = require("snippets/utils")
local partial = require("luasnip.extras").partial

return {
  snippet("time", partial(vim.fn.strftime, "%H:%M:%S")),
  snippet("date", partial(vim.fn.strftime, "%d.%m.%Y")),

  snippet({ trig = "lorem5", descr = "(lorem)" }, {
    text("Lorem ipsum dolor sit amet"),
  }),

  snippet({ trig = "lorem10", descr = "(lorem)" }, {
    text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam"),
  }),

  snippet({ trig = "lorem20", descr = "(lorem)" }, {
    text(
      "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam"
    ),
  }),

  snippet({ trig = "lorem50", descr = "(lorem)" }, {
    text(
      "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."
    ),
  }),

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
