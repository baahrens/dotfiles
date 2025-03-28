local palette = require("nightfox.palette").load("duskfox")

local none = "NONE"

local M = {}

M.highlight_overwrites = {
  GitSignsAdd = { fg = palette.green.base },
  GitSignsChange = { fg = palette.orange.base },
  GitSignsDelete = { fg = palette.red.base },
  StatusLine = { bg = none },
  WinBar = { bg = none },
  WinBarNC = { bg = none },
  CursorLine = { bg = none, bold = true },
  Normal = { bg = none },
  NormalFloat = { bg = none },
  FloatBorder = { bg = none, fg = palette.fg3 },
  FloatTitle = { bg = none, fg = palette.fg1 },
  CmpDocBorder = { fg = palette.fg3, bg = none },
  CmpBorder = { bg = none, fg = palette.fg3 },
  PMenu = { bg = none },
  PmenuThumb = { bg = palette.fg3 },
  PmenuSel = { bg = "#343b47" },
  JsxExpressionBlock = { fg = palette.yellow.base },
  NoiceMini = { bg = none },
  CursorLineNr = { fg = palette.yellow.base },
  Search = { fg = palette.yellow.base, bg = palette.bg3, bold = true },
  HlSearchNear = { fg = palette.cyan.base },
  HlSearchLens = { fg = palette.cyan.base },
  HlSearchLensNear = { fg = palette.cyan.base },
  HlSearchFloat = { fg = palette.cyan.base },

  DiffDelete = { bg = "#4b3346", fg = palette.bg3 },
}

return M
