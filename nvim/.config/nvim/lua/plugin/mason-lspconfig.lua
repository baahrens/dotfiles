require("mason-lspconfig").setup({
  automatic_installation = true,
  ensure_installed = {
    "lua_ls",
    "rust_analyzer",
    "tsserver",
    "jsonls",
    "cssls",
  },
})
