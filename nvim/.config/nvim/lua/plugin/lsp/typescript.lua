local lspconfig = require'lspconfig'
local lsp = require'plugin/lsp'
local u = require("util")

require("lspconfig.configs").vtsls = require("vtsls").lspconfig

lspconfig.vtsls.setup({
  capabilities = lsp.capabilities,
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false

    u.remap("n", "gd", "<cmd>VtsExec goto_source_definition<CR>", { noremap = true, silent = true})

    lsp.on_attach(client)
  end,
})
