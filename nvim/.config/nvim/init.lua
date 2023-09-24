require('plugins')
require('options')
require('mappings')

local theme_name = vim.fn.getenv("THEME") or "duskfox"
require("plugin/colors/theme").set_colorscheme(theme_name)
