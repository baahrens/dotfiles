local lspconfig = require("lspconfig")

lspconfig.tsserver.setup {
  flags = {
    debounce_text_changes = 500
  },

  on_attach = function(client)
    if client.name == "tsserver" then
      client.resolved_capabilities.document_formatting = false
    end
  end,

  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
}
