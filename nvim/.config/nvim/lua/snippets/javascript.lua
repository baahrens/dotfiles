local ls = require("luasnip")
local text = ls.text_node
local insert = ls.insert_node
local snippet = ls.s

local u = require("snippets/utils")

return {
  snippet("console.log()", u.define_pair("console.log(", ")")),
  snippet("console.log({ variable })", u.define_pair("console.log({ ", " })")),
  snippet("console.warn()", u.define_pair("console.warn(", ")")),
  snippet("console.error()", u.define_pair("console.error(", ")")),
  snippet("function with params", {
    text("function "),
    insert(1),
    text("("),
    insert(2),
    text({ ") {", "\t" }),
    insert(3),
    text({ "\t", "}", "\t" }),
  }),
  snippet("function", {
    text("function "),
    insert(1),
    text({ "() {", "\t" }),
    insert(2),
    text({ "\t", "}", "\t" }),
  }),
  snippet("const arrow", {
    text("const "),
    insert(1),
    text(" = () => "),
    insert(2),
  }),
  snippet("const arrow block", {
    text("const "),
    insert(1),
    text({ " = () => {", "\t" }),
    insert(2),
    text({ "\t", "}", "\t" }),
  }),
  snippet("const arrow block with param", {
    text("const "),
    insert(1),
    text("= ("),
    insert(2),
    text({ ") => {", "\t" }),
    insert(3),
    text({ "\t", "}", "\t" }),
  }),
  snippet("test", {
    text("test('"), insert(1), text({ "', () => {", "  " }),
    insert(2),
    text({ "", "})" }),
  }),
  snippet("describe", {
    text("describe('"), insert(1), text({ "', () => {", "  " }),
    insert(2),
    text({ "", "})" }),
  }),
  snippet("for of", {
    text({ "for (const " }), insert(1), text(" of "), insert(2), text({ ") {", "  " }),
    insert(3),
    text({ "", "}" }),
  }),
  snippet("for in", {
    text({ "for (let pos" }), text(" in "), insert(1), text({ ") {", "  " }),
    insert(2),
    text({ "", "}" }),
  }),
  snippet("forEach", {
    text({ "forEach((" }), insert(1), text({ ") => " }), insert(2), text(")"),
  }),
  snippet("forEach block", {
    text({ "forEach((" }), insert(1), text({ ") => {", "  " }),
    insert(2, { "" }),
    text({ "", "})" }),
  }),
  snippet("map", {
    text({ "map((" }), insert(1), text({ ") => " }), insert(2), text(")"),
  }),
  snippet("map block", {
    text({ "map((" }), insert(1), text({ ") => {", "  " }),
    insert(2, { "" }),
    text({ "", "})" }),
  }),
  snippet("jsdoc block", {
    text({ "/**", " * ", }),
    insert(1),
    text({
      "\t",
      " *",
      " * @param ",
    }),
    insert(2),
    text({
      "",
      " * @returns ",
    }),
    insert(3),
    text({
      "",
      " *",
      " */"
    })
  })
}
