local M = {
  format = {
    on_save = true,
    prettier = true,
    eslint = false,
  },
  winblend = 0,
  colorcode_highlights = true,
  border = "rounded",
  diagnostics = {
    show_underline = false,
    show_virtual = false,
    virtual_text = {
      spacing = 4,
      prefix = " 󱞩",
      severity = {
        min = vim.diagnostic.severity.ERROR,
        max = vim.diagnostic.severity.ERROR,
      },
    },
    signs = {
      Hint = "",
      Info = "",
      Warn = "",
      Error = "",
    },
  },
}

local function notify(msg, enabled)
  vim.notify(msg .. " " .. (enabled and "enabled" or "disabled"))
end

function M.toggle_format_on_save()
  M.format.on_save = not M.format.on_save
  notify("Formatting on save", M.format.on_save)
end

function M.toggle_colorcode_highlights()
  M.colorcode_highlights = not M.colorcode_highlights
  vim.cmd("CccHighlighterToggle")
  notify("Colorcode highlighting", M.colorcode_highlights)
end

function M.toggle_format_prettier()
  M.format.prettier = not M.format.prettier
  require("plugin/conform").toggle_prettier(M.format.prettier)
  notify("Formatting with prettier", M.format.prettier)
end

function M.toggle_format_eslint()
  M.format.eslint = not M.format.eslint
  require("plugin/conform").toggle_eslint(M.format.eslint)
  notify("Formatting with eslint", M.format.eslint)
end

function M.toggle_diagnostic_underline()
  M.diagnostics.show_underline = not M.diagnostics.show_underline
  vim.diagnostic.config({
    underline = M.diagnostics.show_underline,
  })
  notify("Diagnostic underlines", M.diagnostics.show_underline)
end

function M.toggle_diagnostic_virtual()
  M.diagnostics.show_virtual = not M.diagnostics.show_virtual
  vim.diagnostic.config({
    virtual_text = M.diagnostics.show_virtual and M.diagnostics.virtual_text or false,
  })
  notify("Diagnostic virtual", M.diagnostics.show_virtual)
end

return M
