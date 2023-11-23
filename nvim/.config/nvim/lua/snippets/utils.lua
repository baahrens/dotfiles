local ls = require("luasnip")

local M = {}

function M.define_pair(left, right)
  return {
    ls.text_node(left),
    ls.insert_node(1),
    ls.text_node(right),
  }
end

return M
