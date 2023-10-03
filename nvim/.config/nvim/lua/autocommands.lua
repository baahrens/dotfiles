-- Disable diagnostics for node_modules
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" },
  { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)" })
