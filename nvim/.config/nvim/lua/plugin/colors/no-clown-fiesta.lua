local palette = require("no-clown-fiesta.palette")

local none = "NONE"

local M = {}

function M.setup()
  require("no-clown-fiesta").setup({
    transparent = false,
    styles = {
      comments = {},
      keywords = {},
      functions = {},
      variables = {},
      type = { bold = true },
      lsp = { underline = false },
    },
  })
end

M.highlight_overwrites = {
  diffAdded = {
    bg = palette.neogit_light_green,
    fg = palette.light_gray,
  },
  diffRemoved = {
    bg = palette.neogit_light_red,
    fg = palette.light_gray,
  },
  diffChanged = { fg = palette.sign_change },
  diffOldFile = { fg = palette.sign_change },
  diffNewFile = { fg = palette.orange },
  diffFile = { fg = palette.neogit_blue },
  diffLine = { fg = palette.gray_blue },
  diffIndexLine = { fg = palette.magenta },

  NoiceLspProgressTitle = { fg = palette.white },

  CmpDocBorder = { fg = palette.medium_gray, bg = none },
  CmpBorder = { fg = palette.medium_gray, bg = none },

  FloatBorder = { fg = palette.medium_gray, bg = none },
  NormalFloat = { bg = none },

  PmenuSel = { bg = "#343b47" },

  LineNr = { fg = palette.medium_gray },
  CursorLineNr = { fg = palette.orange },
}

return M
