local palette = require("nightfox.palette").load("nordfox")

local none = "NONE"

local M = {}

M.highlight_overwrites = {
  GitSignsAdd = { fg = palette.green.base },
  GitSignsChange = { fg = palette.orange.base },
  GitSignsDelete = { fg = palette.red.base },
  FloatTitle = { bg = none, fg = palette.fg1 },
  PmenuThumb = { bg = palette.fg3 },
  JsxExpressionBlock = { fg = palette.yellow.base },
  CursorLineNr = { fg = palette.yellow.base },
  Search = { fg = palette.yellow.base, bg = palette.bg3, bold = true },
  HlSearchNear = { fg = palette.cyan.base },
  HlSearchLens = { fg = palette.cyan.base },
  HlSearchLensNear = { fg = palette.cyan.base },
  HlSearchFloat = { fg = palette.cyan.base },

  DiffDelete = { bg = "#4b3346", fg = palette.bg3 },
}

return M
