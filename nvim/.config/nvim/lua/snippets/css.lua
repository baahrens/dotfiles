local ls = require("luasnip")
local text = ls.text_node
local insert = ls.insert_node
local snippet = ls.s

return {
  snippet("media query", {
    text("@media screen and (min-width: "),
    insert(1),
    text({") {", "\t"}),
    insert(2),
    text({ "\t", "}", "\t" }),
  }),
  snippet("keyframes", {
    text("@keyframes "),
    insert(1),
    text({" {", "\tfrom {", "\t\t" }),
    insert(2),
    text({"\t", "\t}", "\tto {", "\t\t" }),
    insert(3),
    text({ "", "\t}", "}", "" }),
  }),
  snippet("border red", text("border: 1px solid red;")),
}
