require("mason-lspconfig").setup({
  automatic_installation = true,
  ensure_installed = {
    "cssls",
    "jsonls",
    "lua_ls",
    "ols",
    "prismals",
    "rust_analyzer",
    "tailwindcss",
    "tsserver",
    "vtsls",
    "zls"
  },
})
