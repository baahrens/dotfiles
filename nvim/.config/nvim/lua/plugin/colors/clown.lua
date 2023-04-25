local palette = require("no-clown-fiesta.palette")
local util = require("util")

local none = "NONE"

util.overwrite_hl_groups({
		diffAdded = {
			bg = palette.neogit_light_green,
			fg = palette.light_gray,
		},
		diffRemoved = {
			bg = palette.neogit_light_red,
			fg = palette.light_gray,
		},
		diffChanged = { fg = palette.sign_change },
		diffOldFile = { fg = palette.sign_change },
		diffNewFile = { fg = palette.orange },
		diffFile = { fg = palette.neogit_blue },
		diffLine = { fg = palette.gray_blue },
		diffIndexLine = { fg = palette.magenta },

		NoiceLspProgressTitle = { fg = palette.white },

		CmpDocBorder = { fg = palette.medium_gray, bg = none },
		CmpBorder = { fg = palette.medium_gray, bg = none },

		FloatBorder = { fg = palette.medium_gray, bg = none },
		NormalFloat = { bg = none },

		-- PmenuThumb = { bg = duskfox_palette.fg3 },
		PmenuSel = { bg = "#343b47" },

		LineNr = { fg = palette.medium_gray },
		CursorLineNr = { fg = palette.orange },

		TelescopeBorder = { fg = palette.medium_gray, bg = none },
		TelescopeResultsBorder = { fg = palette.medium_gray, bg = none },
		TelescopePreviewBorder = { fg = palette.medium_gray, bg = none },
		TelescopePromptBorder = { fg = palette.medium_gray, bg = none },
})
