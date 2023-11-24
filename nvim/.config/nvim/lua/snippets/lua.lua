local ls = require("luasnip")
local text = ls.text_node
local insert = ls.insert_node
local snippet = ls.s

return {
  snippet("print", {
    text("print("),
    insert(1),
    text(")")
  }),
  snippet("print vim.inspect", {
    text("print(vim.inspect("),
    insert(1),
    text("))")
  }),
  snippet("module", {
    text({ "local M = {}", "\t\t", "return M" }),
  }),
}
