local settings = require("settings")
local lspconfig = require("lspconfig")

vim.lsp.handlers["textDocument/references"] = require("telescope.builtin").lsp_references

local M = {}

for type, icon in pairs(settings.diagnostics.signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local format_clients = {
  "lua_ls",
  "null-ls",
  "prismals",
  "rust_analyzer",
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
    vim.api.nvim_clear_autocmds({ group = formatting_augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = formatting_augroup,
      buffer = bufnr,
      callback = function()
        if settings.format.on_save and client.server_capabilities.document_formatting then
          M.format()
        end
      end,
    })
  end
end

M.on_attach = on_attach

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.diagnostic.config({
  virtual_text = settings.diagnostics.virtual_text,
  float = { border = settings.border, source = true },
  signs = true,
  update_in_insert = false,
  severity_sort = true,
})

lspconfig.cssls.setup({
  capabilities = capabilities,
  on_attach = function(client)
    client.server_capabilities.document_formatting = true
    client.server_capabilities.document_range_formatting = true

    on_attach(client)
  end,
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
    },
  },
  capabilities = capabilities,
  on_attach = function(client)
    client.server_capabilities.document_formatting = true
    client.server_capabilities.document_range_formatting = true

    on_attach(client)
  end,
})

lspconfig.prismals.setup({
  capabilities = capabilities,
  on_attach = function(client)
    client.server_capabilities.document_formatting = true
    client.server_capabilities.document_range_formatting = true

    on_attach(client)
  end,
})

lspconfig.rust_analyzer.setup({
  capabilities = capabilities,
  on_attach = function(client)
    client.server_capabilities.document_formatting = true
    client.server_capabilities.document_range_formatting = true

    on_attach(client)
  end,
})

lspconfig.tailwindcss.setup {
  capabilities = capabilities
}

require("typescript-tools").setup({
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false

    require("util").remap("n", "gd", "<cmd>TSToolsGoToSourceDefinition<CR>", { noremap = true, silent = true })

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
  },
})

lspconfig.zls.setup({
  capabilities = capabilities,
  on_attach = function(client)
    client.server_capabilities.document_formatting = true
    client.server_capabilities.document_range_formatting = true

    on_attach(client)
  end,
})

return M
