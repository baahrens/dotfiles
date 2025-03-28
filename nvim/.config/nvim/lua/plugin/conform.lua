local conform = require("conform")
local settings = require("settings")

local js_filetypes = {
  "javascript",
  "typescript",
  "javascriptreact",
  "json",
  "typescriptreact",
  "astro",
  "html"
}

local js_formatters = { "biome", "prettierd", "prettier", stop_after_first = true }

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
  },
  formatters = {
    prettierd = {
      condition = function()
        return settings.format.prettier
      end,
    },
    eslint_d = {
      condition = function()
        return settings.format.eslint
      end,
    },
  },
  format_on_save = function(bufnr)
    local ignore_filetypes = {}
    if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
      return
    end

    if not settings.format.on_save then
      return
    end

    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname:match("/node_modules/") then
      return
    end
    return { timeout_ms = 500, lsp_format = "fallback" }
  end,
})

for _, v in pairs(js_filetypes) do
  conform.formatters_by_ft[v] = js_formatters
end

local M = {}

function M.toggle_prettier(active)
  conform.formatters.prettierd.condition = function()
    return active
  end
end

function M.toggle_eslint(active)
  conform.formatters.eslint_d.condition = function()
    return active
  end
end

return M
