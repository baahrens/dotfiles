vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    virtual_text = {
      prefix = "",
      spacing = 5
    },
    signs = true,
    underline = true,
    update_in_insert = false
  }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'rounded',
  silent = true,
  focusable = false, -- Sometimes gets set to true if not set explicitly to false for some reason
})

local M = {}

local signs = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " "
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local format_clients = {
    "null-ls",
    "prismals",
    "rust_analyzer"
}

function M.format()
  vim.lsp.buf.format {
    filter = function(lsp_client)
      return vim.tbl_contains(format_clients, lsp_client.name)
    end
  }
end

function M.on_attach (client)
  if client.server_capabilities.document_formatting then
    vim.api.nvim_create_augroup('LspFormatting', {})
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = 'LspFormatting',
      pattern = '*',
      callback = M.format
    })
  end
end

return M
