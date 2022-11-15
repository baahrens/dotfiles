require("luasnip").add_snippets(nil, {
    javascriptreact = {
      unpack(require("snippets/javascript")),
      unpack(require("snippets/react"))
    },
    typescriptreact = {
      unpack(require("snippets/javascript")),
      unpack(require("snippets/react"))
    }
})
