local duskfox_palette = require("nightfox.palette").load("duskfox")
local clown_palette = require("no-clown-fiesta.palette")

local none = "NONE"

local overrides = {
	duskfox = {
		GitSignsAdd = { fg = duskfox_palette.green.base },
		GitSignsChange = { fg = duskfox_palette.orange.base },
		GitSignsDelete = { fg = duskfox_palette.red.base },
		NvimTreeNormal = { bg = none },
		NvimTreeRootFolder = { fg = duskfox_palette.yellow.dim },
		NvimTreeFolderIcon = { fg = duskfox_palette.fg3 },
		NvimTreeOpenedFolderName = {},
		NvimTreeIndentMarker = { fg = duskfox_palette.cyan.base },
		NvimTreeGitNew = { fg = duskfox_palette.yellow.base },
		NvimTreeGitDirty = { fg = duskfox_palette.pink.base },
		NvimTreeSpecialFile = { fg = duskfox_palette.fg1, bold = true },
		StatusLine = { bg = none },
		WinBar = { bg = none },
		WinBarNC = { bg = none },
		CursorLine = { bg = none, bold = true },
		Normal = { bg = none },
		NormalFloat = { bg = none },
		FloatBorder = { bg = none, fg = duskfox_palette.fg3 },
		FloatTitle = { bg = none, fg = duskfox_palette.fg1 },
		CmpDocBorder = { fg = duskfox_palette.fg3, bg = none },
		CmpBorder = { bg = none, fg = duskfox_palette.fg3 },
		PMenu = { bg = none },
		PmenuThumb = { bg = duskfox_palette.fg3 },
		PmenuSel = { bg = "#343b47" },
		TelescopeNormal = { bg = none, fg = duskfox_palette.fg2 },
		TelescopeBorder = { fg = duskfox_palette.cyan.base, bg = none },
		TelescopeResultsBorder = { fg = duskfox_palette.blue.dim, bg = none },
		TelescopePreviewBorder = { fg = duskfox_palette.blue.dim, bg = none },
		TelescopePromptBorder = { fg = duskfox_palette.blue.dim, bg = none },
		TelescopeMatching = { fg = duskfox_palette.yellow.base, bold = true },
		TelescopeSelection = { fg = duskfox_palette.fg0, bold = true },
		TelescopeSelectionCaret = { fg = duskfox_palette.yellow.base },
		JsxExpressionBlock = { fg = duskfox_palette.yellow.base },
		NoiceMini = { bg = none },
		CursorLineNr = { fg = duskfox_palette.yellow.base },
		Search = { fg = duskfox_palette.yellow.base, bg = duskfox_palette.bg3, bold = true },
		HlSearchNear = { fg = duskfox_palette.cyan.base },
		HlSearchLens = { fg = duskfox_palette.cyan.base },
		HlSearchLensNear = { fg = duskfox_palette.cyan.base },
		HlSearchFloat = { fg = duskfox_palette.cyan.base },

		DiffDelete = { bg = "#4b3346", fg = duskfox_palette.bg3 },
	},
	["no-clown-fiesta"] = {
		diffAdded = {
			bg = clown_palette.neogit_light_green,
			fg = clown_palette.light_gray,
		},
		diffRemoved = {
			bg = clown_palette.neogit_light_red,
			fg = clown_palette.light_gray,
		},
		diffChanged = { fg = clown_palette.sign_change },
		diffOldFile = { fg = clown_palette.sign_change },
		diffNewFile = { fg = clown_palette.orange },
		diffFile = { fg = clown_palette.neogit_blue },
		diffLine = { fg = clown_palette.gray_blue },
		diffIndexLine = { fg = clown_palette.magenta },

		NoiceLspProgressTitle = { fg = clown_palette.white },

		CmpDocBorder = { fg = clown_palette.medium_gray, bg = none },
		CmpBorder = { fg = clown_palette.medium_gray, bg = none },

		FloatBorder = { fg = clown_palette.medium_gray, bg = none },
		NormalFloat = { bg = none },

		PmenuThumb = { bg = duskfox_palette.fg3 },
		PmenuSel = { bg = "#343b47" },

		LineNr = { fg = clown_palette.medium_gray },
		CursorLineNr = { fg = clown_palette.orange },
	},
}

vim.api.nvim_create_augroup("colors", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
	group = "colors",
	pattern = "*",
	callback = function(opts)
		local theme_overrides = overrides[opts.match]
		if not theme_overrides then
			return
		end

		for group, spec in pairs(theme_overrides) do
			vim.api.nvim_set_hl(0, group, spec)
		end
	end,
})

vim.cmd("colorscheme no-clown-fiesta")
