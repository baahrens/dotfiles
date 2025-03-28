local utils = require("plugin/colors/utils")
local palette = require("base2tone_drawbridge_dark.palette")

local none = "NONE"

local M = {}

local diagnostic_colors = {
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#67c9e4",
  Hint = "#10B981",
}

M.highlight_overwrites = {
  NormalNC = { bg = palette.B2T_A0 },
  StatusLine = { bg = palette.B2T_A0 },

  Comment = { fg = palette.B2T_A6 },
  Type = { fg = palette.B2T_D1 },
  Todo = { fg = palette.B2T_D4 },
  ["@lsp.type.namespace"] = { fg = palette.B2T_D1 },
  ["@lsp.type.interface"] = { fg = palette.B2T_D1 },

  DiagnosticError = { fg = diagnostic_colors.Error },
  DiagnosticWarn = { fg = diagnostic_colors.Warning },
  DiagnosticInfo = { fg = diagnostic_colors.Information },
  DiagnosticHint = { fg = diagnostic_colors.Hint },

  ["@punctuation"] = { fg = palette.B2T_C3 },

  Pmenu = { bg = palette.B2T_A0 },
  PmenuSel = { fg = palette.B2T_D3 },
  PmenuThumb = { bg = palette.B2T_A3 },
  NormalFloat = { bg = palette.B2T_A0 },
  FloatTitle = { fg = palette.B2T_A6, bg = palette.B2T_A0 },
  FloatBorder = { fg = palette.B2T_A4, bg = palette.B2T_A0 },
  CmpBorder = { fg = palette.B2T_A4, bg = palette.B2T_A0 },

  diffAdded = { fg = utils.darken(diagnostic_colors.Hint, 0.8) },
  diffRemoved = { fg = utils.darken(diagnostic_colors.Error, 0.8) },

  fugitiveUntrackedHeading = { fg = palette.B2T_D1 },
  fugitiveUnstagedHeading = { fg = palette.B2T_D1 },
  GitSignsAdd = { bg = none, fg = utils.darken(diagnostic_colors.Hint, 0.8) },
  GitSignsDelete = { bg = none, fg = utils.darken(diagnostic_colors.Error, 0.8) },
  GitSignsChange = { bg = none, fg = utils.darken(diagnostic_colors.Information, 0.8) },

  TreesitterContextLineNumber = { fg = utils.darken(diagnostic_colors.Information, 0.8) },
}

return M
