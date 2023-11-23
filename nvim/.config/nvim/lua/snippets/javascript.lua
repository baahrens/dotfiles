local ls = require("luasnip")
local snippet = ls.snippet
local text_node = ls.text_node
local insert_node = ls.insert_node

return {
  snippet("console.log()", {
    text_node("console.log("),
    insert_node(1),
    text_node(")"),
  }),
  snippet("console.log({ variable })", {
    text_node("console.log({ "),
    insert_node(1),
    text_node(" })"),
  }),
  snippet("console.warn()", {
    text_node("console.warn("),
    insert_node(1),
    text_node(")"),
  }),
  snippet("console.error()", {
    text_node("console.error("),
    insert_node(1),
    text_node(")"),
  }),
}
