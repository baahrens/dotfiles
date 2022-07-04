local lsp = require'plugin/lsp'

require'lspconfig'.prismals.setup {
  on_attach = function(client)
    client.server_capabilities.document_formatting = true
    client.server_capabilities.document_range_formatting = true

    lsp.on_attach(client)
  end,
}
