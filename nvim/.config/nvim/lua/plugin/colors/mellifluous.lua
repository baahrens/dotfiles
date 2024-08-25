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

require("mellifluous").setup({
  color_set = "kanagawa_dragon",
})

M.highlight_overwrites = {
  fugitiveUntrackedHeading = { fg = palette.B2T_D1 },
  fugitiveUnstagedHeading = { fg = palette.B2T_D1 },

  TelescopeResultsBorder = { fg = palette.medium_gray, bg = none },
  TelescopePromptBorder = { fg = palette.medium_gray, bg = none },
}

return M
