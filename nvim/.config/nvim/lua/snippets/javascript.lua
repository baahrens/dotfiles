local ls = require("luasnip")
local s = ls.snippet
local text_node = ls.text_node
local insert_node = ls.insert_node

return {
  s("cl", { -- console.log
    text_node("console.log("),
    insert_node(1),
    text_node(")"),
  }),
  s("cv", { -- console.log variable
    text_node("console.log({ "),
    insert_node(1),
    text_node(" })"),
  }),
  s("cw", { -- console.warn
    text_node("console.warn("),
    insert_node(1),
    text_node(")"),
  }),
  s("ce", { -- console.error
    text_node("console.warn("),
    insert_node(1),
    text_node(")"),
  }),
}
