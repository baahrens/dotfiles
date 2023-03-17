local lsp = require('plugin/lsp')

require'lspconfig'.lua_ls.setup({
  capabilities = lsp.capabilities,
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false

    lsp.on_attach(client)
  end
})
