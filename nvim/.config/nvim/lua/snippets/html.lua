local ls = require("luasnip")
local text = ls.text_node
local insert = ls.insert_node
local snippet = ls.s

return {
  snippet("doctype", {
    text("<!DOCTYPE html>")
  }),
  snippet("html structure", {
    text({
      "<html lang=\"en\">",
      "\t<head>",
      "\t\t<title>"
    }),
    insert(1),
    text({
      "</title>",
      "\t\t<meta charset=\"UTF-8\">",
      "\t\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">",
      "\t</head>",
      "\t<body>",
      "\t\t",
    }),
    insert(2),
    text({
      "\t",
      "\t</body>",
      "</html>"
    })
  }),
  snippet("css link", {
    text("<link href=\""),
    insert(1),
    text("\" rel=\"stylesheet\">")
  })
}
