local ls = require("luasnip")
local snippet = ls.snippet
local text = ls.text_node
local insert = ls.insert_node
local lambda = require("luasnip.extras").lambda

return {
  snippet("useState", {
    text("const ["),
    insert(1),
    text(", set"),
    lambda(lambda._1:gsub("^%l", string.upper), 1),
    text("] = useState("),
    insert(2),
    text(")"),
  }),
  snippet("useEffect", {
    text({ "useEffect(() => {", "\t" }),
    insert(1),
    text({ "", "}, [" }),
    insert(2),
    text("])"),
  }),
  snippet("useRef", {
    text("const "),
    insert(1),
    text(" = useRef(null)")
  }),
  snippet("useMemo", {
    text("const "),
    insert(1),
    text({ " = useMemo(() => {", "\t" }),
    insert(2),
    text({ "\t", "}, [" }),
    insert(3),
    text("])"),
  }),
  snippet("useCallback", {
    text("const "),
    insert(1),
    text({ " = useCallback(() => {", "\t" }),
    insert(2),
    text({ "\t", "}, [" }),
    insert(3),
    text("])"),
  })

}
