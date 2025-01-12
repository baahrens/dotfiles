local color_utils = require("plugin/colors/utils")
local palette = require("nightfox.palette").load("duskfox")
local M = {}

local function set_theme_env(name)
  vim.fn.system([[fish -c 'set -Ux THEME ]] .. name .. [[']])
end

function M.set_colorscheme(colorscheme)
  if colorscheme then
    set_theme_env(colorscheme)
  end

  local _, colorscheme_conf = pcall(require, "plugin/colors/" .. colorscheme)

  if colorscheme_conf and colorscheme_conf.setup then
    colorscheme_conf.setup()
  end

  vim.cmd("colorscheme" .. " " .. colorscheme)

  color_utils.overwrite_hl_groups(M.global_overrides)
  if colorscheme_conf then
    color_utils.overwrite_hl_groups(colorscheme_conf.highlight_overwrites or {})
  end
end

function M.switch_theme()
  vim.ui.select({
    "base2tone_drawbridge_dark",
    "duskfox",
    "mellifluous",
    "monoglow",
    "no-clown-fiesta",
    "nordfox",
    "oxocarbon",
    "poimandres",
    "rose-pine",
    "tokyobones",
    "tokyonight",
    "zenwritten",
    "lackluster",
  }, {
    prompt = "Switch theme",
  }, M.set_colorscheme)
end

local border_color = color_utils.darken(palette.fg3, 0.7)

local none = "NONE"

M.global_overrides = {
  CursorLine = { bg = none, bold = true },
  LineNr = { fg = palette.fg3 },
  CursorLineNr = { bold = true, fg = palette.fg2 },

  PMenu = { bg = none },
  PmenuSel = { link = "Visual" },
  PmenuThumb = { bg = palette.bg3 },

  NoiceMini = { bg = none },
  NoiceCmdlinePopupBorder = { bg = none, fg = border_color },

  TelescopeNormal = { bg = none },
  TelescopeBorder = { fg = border_color },
  TelescopePreviewBorder = { bg = none, fg = border_color },
  TelescopePreviewNormal = { bg = none },

  FloatBorder = { bg = none, fg = border_color },

  OilFile = { fg = color_utils.lighten(palette.fg3, 0.6) },
  OilDir = { fg = palette.fg2 },
  OilDirIcon = { fg = palette.fg3 },

  CmpDocBorder = { bg = none, fg = border_color },
  CmpBorder = { bg = none, fg = border_color },

  OverseerTaskBorder = { bg = none, fg = border_color },

  MiniIndentscopeSymbol = { link = "FloatBorder" },

  Search = { bg = none, fg = "#ffa400" },
  CurSearch = { bg = none, fg = "#ffa400" },
}

return M
