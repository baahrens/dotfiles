local BORDER = {
  "╭",
  "─",
  "╮",
  "│",
  "╯",
  "─",
  "╰",
  "│",
}

local SIGNS = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " "
}

vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    virtual_text = {
      source = true,
      prefix = "",
      spacing = 5,
    },
    update_in_insert = false,
    severity_sort = true,
  }
)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = BORDER })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = BORDER })
vim.lsp.handlers['textDocument/references'] = function()
  require('telescope.builtin').lsp_references()
end

local M = {}

for type, icon in pairs(SIGNS) do
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
  client.config.flags.debounce_text_changes = 200

  if client.server_capabilities.document_formatting then
    vim.api.nvim_create_augroup('LspFormatting', {})
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = 'LspFormatting',
      pattern = '*',
      callback = M.format
    })
  end
end

M.capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.diagnostic.config({
  virtual_text = { spacing = 4, prefix = '●' },
  float = { border = BORDER, source = 'if_many' },
  signs = true,
  update_in_insert = false,
})

return M
