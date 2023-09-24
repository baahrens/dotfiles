local color_utils = require "plugin/colors/utils"

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

  color_utils.overwrite_hl_groups(colorscheme_conf.highlight_overwrites or {})
end

return M
