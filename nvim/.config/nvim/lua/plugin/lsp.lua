local settings = require("settings")
local lspconfig = require("lspconfig")
local wk = require("which-key")

vim.lsp.handlers["textDocument/references"] = require("snacks").picker.references

local M = {}

for type, icon in pairs(settings.diagnostics.signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local format_clients = {
  "lua_ls",
  "ols",
  "prismals",
  "rust_analyzer",
  "zls",
  "astro",
}

function M.format()
  vim.lsp.buf.format({
    filter = function(lsp_client)
      return vim.tbl_contains(format_clients, lsp_client.name)
    end,
  })
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LSP", {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local bufnr = args.buf
    local formatting_augroup = vim.api.nvim_create_augroup("Formatting", { clear = true })

    if client.supports_method("textDocument/formatting") then
      client.server_capabilities.document_formatting = vim.tbl_contains(format_clients, client.name)
      client.server_capabilities.document_range_formatting = vim.tbl_contains(format_clients, client.name)

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
  signs = true,
  update_in_insert = false,
  severity_sort = true,
})

local language_servers = {
  "cssls",
  "jsonls",
  "lua_ls",
  "lua_ls",
  "ols",
  "prismals",
  "pyright",
  "rust_analyzer",
  "sourcekit",
  "tailwindcss",
  "zls",
}

for _, server in ipairs(language_servers) do
  vim.lsp.enable(server)
end

-- lspconfig.lua_ls.setup({
--   settings = {
--     Lua = {
--       runtime = {
--         version = "LuaJIT",
--       },
--       diagnostics = {
--         globals = { "vim" },
--       },
--       workspace = {
--         library = vim.api.nvim_get_runtime_file("", true),
--         checkThirdParty = false,
--       },
--       telemetry = {
--         enable = false,
--       },
--       format = {
--         enable = false,
--       },
--     },
--   },
--   on_attach = on_attach,
-- })
--

-- require("typescript-tools").setup({
--   on_attach = function(client)
--     client.server_capabilities.document_formatting = false
--     client.server_capabilities.document_range_formatting = false
--     wk.add({
--       { "gd", "<cmd>TSToolsGoToSourceDefinition<CR>", { noremap = true, silent = true } },
--       { "gD", "<cmd>vsplit +TSToolsGoToSourceDefinition<CR>", { noremap = true, silent = true } },
--     })
--
--     on_attach(client)
--   end,
--   settings = {
--     separate_diagnostic_server = true,
--     publish_diagnostic_on = "insert_leave",
--     expose_as_code_action = { "fix_all", "add_missing_imports", "remove_unused" },
--     tsserver_path = nil,
--     tsserver_plugins = {},
--     tsserver_max_memory = "auto",
--     tsserver_format_options = {},
--     tsserver_file_preferences = {},
--     complete_function_calls = false,
--
--     jsx_close_tag = {
--       enable = true,
--       filetypes = { "javascriptreact", "typescriptreact" },
--     },
--   },
-- })

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
