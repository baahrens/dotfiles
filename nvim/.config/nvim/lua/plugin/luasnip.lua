require("luasnip").add_snippets(nil, {
  all = {
    unpack(require("snippets/all")),
  },
  typescript = {
    unpack(require("snippets/javascript")),
  },
  javascript = {
    unpack(require("snippets/javascript")),
  },
  typescriptreact = {
    unpack(require("snippets/javascript")),
    unpack(require("snippets/react")),
  },
  javascriptreact = {
    unpack(require("snippets/javascript")),
    unpack(require("snippets/react")),
  },
})
