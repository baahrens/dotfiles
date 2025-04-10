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

local function on_attach(client, bufnr)
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
end

M.on_attach = on_attach

vim.diagnostic.config({
  virtual_text = false,
  underline = settings.diagnostics.show_underline,
  float = { border = settings.border, source = true },
  signs = true,
  update_in_insert = false,
  severity_sort = true,
  underline = settings.diagnostics.show_underline,
})

lspconfig.cssls.setup({
  on_attach = on_attach,
})

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
      format = {
        enable = false,
      },
    },
  },
  on_attach = on_attach,
})

lspconfig.prismals.setup({
  on_attach = on_attach,
})

lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
})

lspconfig.tailwindcss.setup({})

require("typescript-tools").setup({
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false

    on_attach(client)
  end,
  settings = {
    separate_diagnostic_server = true,
    publish_diagnostic_on = "insert_leave",
    expose_as_code_action = { "fix_all", "add_missing_imports", "remove_unused" },
    tsserver_path = nil,
    tsserver_plugins = {},
    tsserver_max_memory = "auto",
    tsserver_format_options = {},
    tsserver_file_preferences = {},
    complete_function_calls = false,

    jsx_close_tag = {
      enable = true,
      filetypes = { "javascriptreact", "typescriptreact" },
    },
  },
})

lspconfig.zls.setup({
  on_attach = on_attach,
})

lspconfig.astro.setup({
  on_attach = on_attach,
})

lspconfig.ols.setup({
  on_attach = on_attach,
})

lspconfig.pyright.setup({
  on_attach = on_attach,
})

lspconfig.jsonls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

return M
