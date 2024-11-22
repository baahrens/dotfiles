local M = {}

function M.setup()
  require('rose-pine').setup({
    variant = "moon",
    disable_italics = true,
    disable_background = false,
    highlight_groups = {
      TelescopeBorder = { fg = "highlight_high", bg = "none" },
      TelescopeNormal = { bg = "none" },
      TelescopePromptNormal = { bg = "none" },
      TelescopeResultsNormal = { fg = "subtle", bg = "none" },
    },
  })
end

return M
