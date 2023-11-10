require("mason-lspconfig").setup({
  automatic_installation = true,
  ensure_installed = {
    "prismals",
    "lua_ls",
    "rust_analyzer",
    "tsserver",
    "jsonls",
    "cssls",
    "tailwindcss",
    "vtsls",
    "zls"
  },
})
