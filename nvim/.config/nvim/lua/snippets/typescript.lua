local ls = require("luasnip")
local text = ls.text_node
local insert = ls.insert_node
local snippet = ls.s

return {
  snippet("deprecated", {
    text({ "/**", "* @deprecated " }),
    insert(1),
    text({ "\t", "*/" }),
  }),
}
