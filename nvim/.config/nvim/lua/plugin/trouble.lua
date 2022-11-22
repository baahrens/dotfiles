require("trouble").setup({
  position = "bottom",
  height = 10,
  icons = true,
  mode = "workspace_diagnostics", -- "lsp_workspace_diagnostics", "lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
  fold_open = "",
  fold_closed = "",
  use_diagnostic_signs = true,
  auto_close = true,
})
