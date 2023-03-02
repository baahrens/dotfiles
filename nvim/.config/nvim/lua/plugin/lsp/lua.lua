local lsp = require('plugin/lsp')

require'lspconfig'.lua_ls.setup({
  debounce_text_changes = 500,
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace"
      }
    }
  }
})
