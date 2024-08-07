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
  diffAdded = { fg = utils.darken(diagnostic_colors.Hint, 0.8) },
  diffRemoved = { fg = utils.darken(diagnostic_colors.Error, 0.8) },

  fugitiveUntrackedHeading = { fg = palette.B2T_D1 },
  fugitiveUnstagedHeading = { fg = palette.B2T_D1 },

  GitSignsAdd = { bg = none, fg = utils.darken(diagnostic_colors.Hint, 0.8) },
  GitSignsDelete = { bg = none, fg = utils.darken(diagnostic_colors.Error, 0.8) },
  GitSignsChange = { bg = none, fg = utils.darken(diagnostic_colors.Warning, 0.8) },
}

return M
