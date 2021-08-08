local lspconfig = require'lspconfig'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.cssls.setup{
  on_attach = require('plugin/lsp').on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 500
  }
}
