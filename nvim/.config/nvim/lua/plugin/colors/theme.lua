local color_utils = require "plugin/colors/utils"
local palette = require("nightfox.palette").load("duskfox")

local M = {}

local function set_theme_env(name)
  vim.fn.system([[fish -c 'set -Ux THEME "]] .. name .. [["']])
end

function M.set_colorscheme(colorscheme)
  if colorscheme then
    set_theme_env(colorscheme)
  end

  local ok, colorscheme_conf = pcall(require, "plugin/colors/" .. colorscheme)
  if not ok then
    print("Error loading colorscheme config: " .. colorscheme)
    print(colorscheme_conf)
    return
  end

  if colorscheme_conf.setup then
    colorscheme_conf.setup()
  end

  vim.cmd("colorscheme" .. " " .. colorscheme)

  color_utils.overwrite_hl_groups(M.global_overrides)
  color_utils.overwrite_hl_groups(colorscheme_conf.highlight_overwrites or {})
end

function M.switch_theme()
  vim.ui.select({
    "mellifluous",
    "duskfox",
    "base2tone_drawbridge_dark",
    "no-clown-fiesta",
    "tokyonight",
    "nordfox",
    "rose-pine",
    "tokyobones",
    "zenwritten"
  }, {
    prompt = 'Switch theme',
  }, M.set_colorscheme)
end

local none = "NONE"

M.global_overrides = {
  SignColumn = { bg = none },
  CursorLine = { bg = none, bold = true },
  StatusLine = { bg = none },
  WinBar = { bg = none },
  LineNr = { bg = none, fg = palette.fg3 },
  WinBarNC = { bg = none },

  Normal = { bg = none },
  NormalFloat = { bg = none },

  PMenu = { bg = none },
  PmenuSel = { bg = "#343b47" },
  PmenuThumb = { bg = palette.fg3 },

  NoiceMini = { bg = none },
  NoiceCmdlinePopupBorder = { bg = none, fg = color_utils.darken(palette.fg3, 0.7) },

  NvimTreeNormal = { bg = none },

  TelescopeResultsLineNr = { fg = palette.fg3 },
  TelescopeNormal = { bg = none },
  TelescopeBorder = { fg = color_utils.darken(palette.fg3, 0.7) },
  TelescopePreviewBorder = { bg = none, fg = color_utils.darken(palette.fg3, 0.7) },

  FloatBorder = { bg = none, fg = color_utils.darken(palette.fg3, 0.7) },
  CmpDocBorder = { bg = none, fg = color_utils.darken(palette.fg3, 0.7) },
  CmpBorder = { bg = none, fg = color_utils.darken(palette.fg3, 0.7) },

  IblIndent = { bg = none, fg = color_utils.darken(palette.fg3, 0.7) },
  IblScope = { bg = none, fg = palette.fg3 },

  WhichKeyGroup = { fg = "#e0af68" },
  OilFile = { fg = color_utils.lighten(palette.fg3, 0.6) },
  OilDir = { fg = palette.fg2 },
  OilDirIcon = { fg = palette.fg3 },

  CmpItemKindSnippet = { fg = "#e0af68" },
  OverseerTaskBorder = { bg = none, fg = palette.bg2 },
}

return M
