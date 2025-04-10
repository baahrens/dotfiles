require("mason-lspconfig").setup({
  automatic_installation = true,
  ensure_installed = {
    "cssls",
    "jsonls",
    "lua_ls",
    "ols",
    "prismals",
    "pyright",
    "rust_analyzer",
    "tailwindcss",
    "ts_ls",
    "vtsls",
    "zls",
  },
})
