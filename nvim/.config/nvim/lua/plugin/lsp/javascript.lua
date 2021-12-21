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
  root_dir = function(fname)
  return lspconfig.util.root_pattern('tsconfig.json')(fname)
    or not lspconfig.util.root_pattern('.flowconfig')(fname)
    and lspconfig.util.root_pattern('package.json', 'jsconfig.json', '.git')(fname)
  end,
}

-- lspconfig.flow.setup {
--   on_attach = function(client)
--     client.resolved_capabilities.document_formatting = false
--     on_attach(client)
--   end,
--   name = 'flow',
--   cmd = { 'npx', '--no-install', 'flow', 'lsp' },
--   filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx' },
--   flags = {
--     debounce_text_changes = 500
--   },
--   capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- }
