local palette = require("no-clown-fiesta.palette")
local utils = require("plugin/colors/utils")

local none = "NONE"

local M = {}

local diagnostic_colors = {
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#67c9e4",
  Hint = "#10B981",
}

M.highlight_overwrites = {
  StatusLine = { bg = none },
  WinBar = { bg = none },
  WinBarNC = { bg = none },
  CursorLine = { bg = none, bold = true },
  Normal = { bg = none },
  NormalFloat = { bg = none },
  NoiceMini = { bg = none },

  diffAdded = { fg = utils.darken(diagnostic_colors.Hint, 0.8) },
  diffRemoved = { fg = utils.darken(diagnostic_colors.Error, 0.8) },

  DiagnosticError = { fg = diagnostic_colors.Error },
  DiagnosticWarn = { fg = diagnostic_colors.Warning },
  DiagnosticInfo = { fg = diagnostic_colors.Information },
  DiagnosticHint = { fg = diagnostic_colors.Hint },

  DiagnosticSignError = { fg = diagnostic_colors.Error },
  DiagnosticSignWarn = { fg = diagnostic_colors.Warning },
  DiagnosticSignInfo = { fg = diagnostic_colors.Information },
  DiagnosticSignHint = { fg = diagnostic_colors.Hint },

  DiagnosticVirtualTextError = { fg = utils.darken(diagnostic_colors.Error, 0.8) },
  DiagnosticVirtualTextWarn = { fg = utils.darken(diagnostic_colors.Warning, 0.8) },
  DiagnosticVirtualTextInfo = { fg = utils.darken(diagnostic_colors.Information, 0.8) },
  DiagnosticVirtualTextHint = { fg = utils.darken(diagnostic_colors.Hint, 0.8) },

  fugitiveUntrackedHeading = { fg = palette.B2T_D1 },
  fugitiveUnstagedHeading = { fg = palette.B2T_D1 },
  GitSignsAdd = { bg = none, fg = utils.darken(diagnostic_colors.Hint, 0.8) },
  GitSignsDelete = { bg = none, fg = utils.darken(diagnostic_colors.Error, 0.8) },
  GitSignsChange = { bg = none, fg = utils.darken(diagnostic_colors.Warning, 0.8) },

  NvimTreeNormal = { fg = palette.B2T_B5 },
  NvimTreeGitNew = { fg = utils.darken(diagnostic_colors.Hint, 0.8) },
  NvimTreeGitDirty = { fg = utils.darken(diagnostic_colors.Warning, 0.8) },
  NvimTreeGitDeleted = { fg = utils.darken(diagnostic_colors.Error, 0.8) },
  NvimTreeGitStaged = { fg = utils.darken(diagnostic_colors.Information, 0.8) },
}

return M
