local ls = require("luasnip")
local text = ls.text_node
local snippet = ls.s

return {
  snippet("changeset", text("build: Add changeset")),
  snippet("dependencies", text("chore: Upgrade dependencies")),
  snippet("snapshots", text("test: Update snapshots")),
}
