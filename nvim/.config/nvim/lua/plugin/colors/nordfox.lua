local palette = require("nightfox.palette").load("nordfox")

local none = "NONE"

local M = {}

M.highlight_overwrites = {
  GitSignsAdd = { fg = palette.green.base },
  GitSignsChange = { fg = palette.orange.base },
  GitSignsDelete = { fg = palette.red.base },
  NvimTreeNormal = { bg = none },
  NvimTreeRootFolder = { fg = palette.yellow.dim },
  NvimTreeFolderIcon = { fg = palette.fg3 },
  NvimTreeOpenedFolderName = {},
  NvimTreeIndentMarker = { fg = palette.cyan.base },
  NvimTreeGitNew = { fg = palette.yellow.base },
  NvimTreeGitDirty = { fg = palette.pink.base },
  NvimTreeSpecialFile = { fg = palette.fg1, bold = true },
  FloatTitle = { bg = none, fg = palette.fg1 },
  PmenuThumb = { bg = palette.fg3 },
  TelescopeNormal = { bg = none, fg = palette.fg2 },
  TelescopeBorder = { fg = palette.cyan.base, bg = none },
  TelescopeResultsBorder = { fg = palette.blue.dim, bg = none },
  TelescopePreviewBorder = { fg = palette.blue.dim, bg = none },
  TelescopePromptTitle = { bg = none },
  TelescopePromptBorder = { fg = palette.blue.dim, bg = none },
  TelescopeMatching = { fg = palette.yellow.base, bold = true },
  TelescopeSelection = { fg = palette.fg0, bold = true },
  TelescopeSelectionCaret = { fg = palette.yellow.base },
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
