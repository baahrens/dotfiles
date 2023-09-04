local color_utils = require"plugin/colors/utils"
local utils = require("util")

local dotfile_path
local alacritty_path
local escaped_alacritty_path

local M = {}

if utils.is_macos() then
  dotfile_path = "~/.dotfiles"
  alacritty_path = dotfile_path .. "/alacritty/.config/alacritty/alacritty.yml"
  escaped_alacritty_path = [[~\/\.dotfiles\/alacritty\/\.config\/alacritty\/]]
else
  dotfile_path = "~/dotfiles"
  alacritty_path = dotfile_path .. "/alacritty_linux/.config/alacritty/alacritty.yml"
  escaped_alacritty_path = [[~\/dotfiles\/alacritty_linux\/\.config\/alacritty\/]]
end

local function set_tmux_colors(color)
  vim.fn.system([[fish -c 'set -Ux BACKGROUND_COLOR "]] .. color .. [["']])
  vim.fn.system([[tmux set-environment -g "BACKGROUND_COLOR" "]] .. color .. '"')
  vim.fn.system("tmux source-file" .. " " .. dotfile_path .. "/tmux/.tmux.conf")
end

local function set_alacritty_theme(name)
  vim.fn.system("sed -i '' '2s/.*/  - " .. escaped_alacritty_path .. name .. ".yml/'" .. " " .. alacritty_path)
end

local function set_theme_env(name)
  vim.fn.system([[fish -c 'set -Ux THEME "]] .. name .. [["']])
end

local themes = {
  tokyonight = {
    bg = "#1a1b26",
    alacritty_theme = "tokyonight",
  },
  mellifluous = {
    bg = "#1a1a1a",
    alacritty_theme = "everforest",
  },
  duskfox = {
    bg = "#1b1f32",
    alacritty_theme = "duskfox",
  },
  base2tone_drawbridge_dark = {
    bg = "#1b1f32",
    alacritty_theme = "duskfox",
  },
  ["no-clown-fiesta"] = {
    bg = "#151515",
    alacritty_theme = "clown",
  },
  nordfox = {
    bg = "#373e4d",
    alacritty_theme = "nord",
  },
}

function M.set_colorscheme(colorscheme)
  local theme_name = colorscheme or vim.fn.getenv("THEME")
  if theme_name == vim.NIL then
    theme_name = "duskfox"
  end

  local conf = themes[theme_name]
  if not conf then
    return
  end

  -- if a colorscheme is passed, this is not the initial colorscheme load
  -- so we need to set all the themes
  if colorscheme then
    set_theme_env(theme_name)
    set_tmux_colors(conf.bg)
    set_alacritty_theme(conf.alacritty_theme)
  end

  local ok, colorscheme_conf = pcall(require, "plugin/colors/" .. theme_name)
  if not ok then
    print("Error loading colorscheme config: " .. theme_name)
    print(colorscheme_conf)
    return
  end

  -- setup colorscheme if needed
  if colorscheme_conf.setup then
    colorscheme_conf.setup()
  end

  vim.cmd("colorscheme" .. " " .. theme_name)

  color_utils.overwrite_hl_groups(colorscheme_conf.highlight_overwrites or {})
end

return M
