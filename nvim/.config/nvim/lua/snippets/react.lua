local ls = require("luasnip")
local snippet = ls.snippet
local text_node = ls.text_node
local insert_node = ls.insert_node
local lambda = require("luasnip.extras").lambda

return {
  -- useState
  snippet("us", {
    text_node("const ["),
    insert_node(1),
    text_node(", set"),
    lambda(lambda._1:gsub("^%l", string.upper), 1),
    text_node("] = useState("),
    insert_node(2),
    text_node(")"),
  }),
  -- useEffect
  snippet("ue", {
    text_node({ "useEffect(() => {", "\t" }),
    insert_node(1),
    text_node({ "", "}, [" }),
    insert_node(2),
    text_node("])"),
  }),
  -- useRef
  snippet("ur", {
    text_node("const "),
    insert_node(1),
    text_node(" = useRef(null)")
  }),
  -- useMemo
  snippet("um", {
    text_node("const "),
    insert_node(1),
    text_node({ " = useMemo(() => {", "\t" }),
    insert_node(2),
    text_node({ "\t", "}, [" }),
    insert_node(3),
    text_node("])"),
  }),
  -- useCallback
  snippet("uc", {
    text_node("const "),
    insert_node(1),
    text_node({ " = useCallback(() => {", "\t" }),
    insert_node(2),
    text_node({ "\t", "}, [" }),
    insert_node(3),
    text_node("])"),
  })

}
