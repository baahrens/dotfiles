local colors = {
    bg = "#2e3440",
    fg = "#ECEFF4",
    red = "#bf616a",
    orange = "#d08770",
    yellow = "#ebcb8b",
    blue = "#5e81ac",
    green = "#a3be8c",
    cyan = "#88c0d0",
    magenta = "#b48ead",
    pink = "#FFA19F",
    grey1 = "#f8fafc",
    grey2 = "#f0f1f4",
    grey3 = "#eaecf0",
    grey4 = "#d9dce3",
    grey5 = "#c4c9d4",
    grey6 = "#b5bcc9",
    grey7 = "#929cb0",
    grey8 = "#8e99ae",
    grey9 = "#74819a",
    grey10 = "#616d85",
    grey11 = "#464f62",
    grey12 = "#3a4150",
    grey13 = "#333a47",
    grey14 = "#242932",
    grey15 = "#1e222a",
    grey16 = "#1c1f26",
    grey17 = "#0f1115",
    grey18 = "#0d0e11",
    grey19 = "#020203",
}

local none = "NONE"

require('onenord').setup({
  borders = true,
  disable = {
    background = true
  },
  styles = {
    comments = "italic",
    strings = none,
    keywords = none,
    variables = none,
    diagnostics = "underline",
  },
  custom_highlights = {
    GitSignsAdd = { fg = colors.green },
    GitSignsChange = { fg = colors.orange },
    GitSignsDelete = { fg = colors.red },

    NvimTreeFolderIcon = { fg = colors.grey9 },
    NvimTreeOpenedFolderName = { style = none },
    NvimTreeIndentMarker = { fg = colors.grey12 },
    NvimTreeGitNew = { fg = colors.yellow },
    NvimTreeGitDirty = { fg = colors.pink },
    NvimTreeSpecialFile = { fg = colors.fg, style = "bold" },

    StatusLine = { bg = none },
    WinBar = { bg = none },
    WinBarNC = { bg = none },

    CursorLine = { bg = none, style = "bold" },

    NormalFloat = { bg = none },
    FloatBorder = { bg = none, fg = colors.grey9 },
    FloatTitle = { bg = none, fg = colors.fg },

    CmpDocBorder = { fg = colors.grey9, bg = none },
    CmpBorder = { bg = none, fg = colors.grey9 },

    PmenuThumb = { bg = colors.grey9  },
    PmenuSel = { bg = "#343b47" },

    TelescopeNormal = { bg = none },
    TelescopeBorder = { fg = colors.grey9, bg = none },
    TelescopeResultsBorder = { fg = colors.grey9, bg = none },
    TelescopePreviewBorder = { fg = colors.grey9, bg = none },
    TelescopePromptBorder = { fg = colors.grey9, bg = none },

    JsxExpressionBlock = { fg = colors.yellow },

    CursorLineNr = { fg = colors.yellow },

    Search = { fg = colors.yellow , bg = colors.grey11, bold = true },

    HlSearchNear = { fg = colors.cyan },
    HlSearchLens = { fg= colors.cyan },
    HlSearchLensNear = { fg = colors.cyan },
    HlSearchFloat = { fg = colors.cyan },
  }
})
