local color_utils = require "plugin/colors/utils"
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
  }, {
    prompt = 'Switch theme',
  }, M.set_colorscheme)
end

local diagnostic_colors = {
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#67c9e4",
  Hint = "#10B981",
}

local none = "NONE"

M.global_overrides = {
  SignColumn = { bg = none },
  CursorLine = { bg = none, bold = true },
  LineNr = { bg = none, fg = palette.fg3 },
  CursorLineNr = { bg = none, bold = true, fg = palette.fg2 },
  StatusLine = { bg = none },
  WinBar = { bg = none },
  WinBarNC = { bg = none },

  Normal = { bg = none },
  NormalNC = { bg = none },
  NormalFloat = { bg = none },

  String = { italic = false },

  PMenu = { bg = none },
  PmenuSel = { link = "Visual" },
  PmenuThumb = { bg = palette.bg3 },

  NoiceMini = { bg = none },
  NoiceCmdlinePopupBorder = { bg = none, fg = color_utils.darken(palette.fg3, 0.7) },

  TelescopeResultsLineNr = { fg = palette.fg3 },
  TelescopeNormal = { bg = none },
  TelescopeBorder = { fg = color_utils.darken(palette.fg3, 0.7) },
  TelescopePreviewBorder = { bg = none, fg = color_utils.darken(palette.fg3, 0.7) },
  TelescopePreviewNormal = { bg = none },

  FloatBorder = { bg = none, fg = color_utils.darken(palette.fg3, 0.7) },

  IblIndent = { bg = none, fg = color_utils.darken(palette.fg3, 0.7) },
  IblScope = { bg = none, fg = palette.fg3 },

  WhichKeyGroup = { fg = diagnostic_colors.Warning },

  OilFile = { fg = color_utils.lighten(palette.fg3, 0.6) },
  OilDir = { fg = palette.fg2 },
  OilDirIcon = { fg = palette.fg3 },

  -- DiagnosticError = { fg = diagnostic_colors.Error },
  -- DiagnosticWarn = { fg = diagnostic_colors.Warning },
  -- DiagnosticInfo = { fg = diagnostic_colors.Information },
  -- DiagnosticHint = { fg = diagnostic_colors.Hint },

  CmpDocBorder = { bg = none, fg = color_utils.darken(palette.fg3, 0.7) },
  CmpBorder = { bg = none, fg = color_utils.darken(palette.fg3, 0.7) },
  CmpItemKindSnippet = { fg = "#e0af68" },
  CmpItemMenu = { fg = color_utils.darken(palette.fg3, 0.7) },

  OverseerTaskBorder = { bg = none, fg = palette.bg2 },
}

return M
