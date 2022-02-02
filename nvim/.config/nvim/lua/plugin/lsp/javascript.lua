local lspconfig = require("lspconfig")
local on_attach = require ('plugin/lsp').on_attach

lspconfig.tsserver.setup {
  flags = {
    debounce_text_changes = 500
  },

  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    on_attach(client)
  end,

  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
}
