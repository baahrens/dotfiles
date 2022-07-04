local lspconfig = require'lspconfig'
local lsp = require'plugin/lsp'

lspconfig.tsserver.setup {
  flags = {
    debounce_text_changes = 500
  },

  on_attach = function(client)
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false

    lsp.on_attach(client)
  end,
}
