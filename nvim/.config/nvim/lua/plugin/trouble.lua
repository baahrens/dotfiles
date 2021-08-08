require("trouble").setup({
  position    = "bottom", -- position of the list can be: bottom, top, left, right
  height      = 7, -- height of the trouble list when position is top or bottom
  icons       = true, -- use devicons for filenames
  mode        = "lsp_workspace_diagnostics", -- "lsp_workspace_diagnostics", "lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
  fold_open   = "", -- icon used for open folds
  fold_closed = "", -- icon used for closed folds
})
