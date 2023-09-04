local lsp = require('plugin/lsp')
require 'lspconfig'.tailwindcss.setup {
  capabilities = lsp.capabilities
}
