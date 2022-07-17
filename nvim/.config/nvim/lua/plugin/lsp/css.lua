local lspconfig = require'lspconfig'
local lsp = require('plugin/lsp')

lsp.capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.cssls.setup{
  capabilities = lsp.capabilities,
}
