require'lspconfig'.prismals.setup {
  on_attach = function()
    vim.cmd([[
      augroup LspFormatting
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
      augroup END
    ]])
  end,
}
