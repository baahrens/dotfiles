local settings = require("settings")
local lspconfig = require("lspconfig")
local wk = require("which-key")

vim.lsp.handlers["textDocument/references"] = require("snacks").picker.references

local M = {}

for type, icon in pairs(settings.diagnostics.signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

M.language_servers = {
  "astro",
  "cssls",
  "jsonls",
  "lua_ls",
  "ols",
  "prismals",
  "pyright",
  "rust_analyzer",
  "sourcekit",
  "tailwindcss",
  "ts_ls",
  "gopls",
  "zls",
}


local format_language_servers = {
  "astro",
  "ols",
  "prismals",
  "rust_analyzer",
  "zls",
}

function M.format()
  vim.lsp.buf.format({
    filter = function(lsp_client)
      return vim.tbl_contains(format_language_servers, lsp_client.name)
    end,
  })
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LSP", {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local bufnr = args.buf
    local formatting_augroup = vim.api.nvim_create_augroup("Formatting", { clear = true })

    -- if (client.name == "ts_ls") then
    --     wk.add({
    --     { "gd", "<cmd>LspTypescriptGoToSourceDefinition<CR>", { noremap = true, silent = true } },
    --     { "gD", "<cmd>vsplit +LspTypescriptGoToSourceDefinition<CR>", { noremap = true, silent = true } },
    --     })
    -- end

    if client.supports_method("textDocument/formatting") then
      client.server_capabilities.document_formatting = vim.tbl_contains(format_language_servers, client.name)
      client.server_capabilities.document_range_formatting = vim.tbl_contains(format_language_servers, client.name)

      vim.api.nvim_clear_autocmds({ group = formatting_augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = formatting_augroup,
        buffer = bufnr,
        callback = function()
          if settings.format.on_save then
            M.format()
          end
        end,
      })
    end
  end,
})

vim.diagnostic.config({
  virtual_text = false,
  underline = settings.diagnostics.show_underline,
  float = { border = settings.border, source = true },
  signs = false,
  update_in_insert = false,
  severity_sort = true,
})

for _, server in ipairs(M.language_servers) do
  vim.lsp.enable(server)
end

-- lspconfig.sourcekit.setup({
--   -- capabilities = capabilities,
--   capabilities = {
--     workspace = {
--       didChangeWatchedFiles = {
--         dynamicRegistration = true,
--       },
--     },
--   },
-- })

return M
