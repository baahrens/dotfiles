local palette = require("nightfox.palette").load("duskfox")

local none = "NONE"

local custom_highlights = {
	GitSignsAdd = { fg = palette.green.base },
	GitSignsChange = { fg = palette.orange.base },
	GitSignsDelete = { fg = palette.red.base },
	NvimTreeNormal = { bg = none },
	NvimTreeRootFolder = { fg = palette.yellow.dim },
	NvimTreeFolderIcon = { fg = palette.fg3 },
	NvimTreeOpenedFolderName = {},
	NvimTreeIndentMarker = { fg = palette.cyan.base },
	NvimTreeGitNew = { fg = palette.yellow.base },
	NvimTreeGitDirty = { fg = palette.pink.base },
	NvimTreeSpecialFile = { fg = palette.fg1, bold = true },
	StatusLine = { bg = none },
	WinBar = { bg = none },
	WinBarNC = { bg = none },
	CursorLine = { bg = none, bold = true },
	Normal = { bg = none },
	NormalFloat = { bg = none },
	FloatBorder = { bg = none, fg = palette.fg3 },
	FloatTitle = { bg = none, fg = palette.fg1 },
	CmpDocBorder = { fg = palette.fg3, bg = none },
	CmpBorder = { bg = none, fg = palette.fg3 },
	PMenu = { bg = none },
	PmenuThumb = { bg = palette.fg3 },
	PmenuSel = { bg = "#343b47" },
	TelescopeNormal = { bg = none, fg = palette.fg2 },
	TelescopeBorder = { fg = palette.cyan.base, bg = none },
	TelescopeResultsBorder = { fg = palette.blue.dim, bg = none },
	TelescopePreviewBorder = { fg = palette.blue.dim, bg = none },
	TelescopePromptBorder = { fg = palette.blue.dim, bg = none },
	TelescopeMatching = { fg = palette.yellow.base, bold = true },
	TelescopeSelection = { fg = palette.fg0, bold = true },
	TelescopeSelectionCaret = { fg = palette.yellow.base },
	JsxExpressionBlock = { fg = palette.yellow.base },
	NoiceMini = { bg = none },
	CursorLineNr = { fg = palette.yellow.base },
	Search = { fg = palette.yellow.base, bg = palette.bg3, bold = true },
	HlSearchNear = { fg = palette.cyan.base },
	HlSearchLens = { fg = palette.cyan.base },
	HlSearchLensNear = { fg = palette.cyan.base },
	HlSearchFloat = { fg = palette.cyan.base },
}

vim.api.nvim_create_augroup("colors", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
	group = "colors",
	pattern = "*",
	callback = function()
		for group, spec in pairs(custom_highlights) do
			vim.api.nvim_set_hl(0, group, spec)
		end
	end,
})

vim.cmd("colorscheme duskfox")
