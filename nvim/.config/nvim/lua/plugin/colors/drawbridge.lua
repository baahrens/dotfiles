local drawbridge_palette  = require('base2tone_drawbridge_dark.palette')
local util = require("util")

util.overwrite_hl_groups({
  NormalNC = { fg = drawbridge_palette.B2T_B5, bg = drawbridge_palette.B2T_A0 }
})
