local utils = require("plugin/colors/utils")

local none = "NONE"

local colors = {
  B2T_A0 = "#1b1f32",
  B2T_A1 = "#252a41",
  B2T_A2 = "#444b6f",
  B2T_A3 = "#51587b",
  B2T_A4 = "#5e6587",
  B2T_A5 = "#797e96",
  B2T_A6 = "#9094a7",
  B2T_A7 = "#a6aab9",
  B2T_B0 = "#4961da",
  B2T_B1 = "#516aec",
  B2T_B2 = "#627af4",
  B2T_B3 = "#7289fd",
  B2T_B4 = "#8b9efd",
  B2T_B5 = "#a5b3fe",
  B2T_B6 = "#c3cdfe",
  B2T_B7 = "#e1e6ff",
  B2T_C0 = "#71787a",
  B2T_C1 = "#818b8d",
  B2T_C2 = "#939c9f",
  B2T_C3 = "#a6aeb0",
  B2T_C4 = "#b7c0c2",
  B2T_C5 = "#cbd4d7",
  B2T_C6 = "#e1e8ea",
  B2T_C7 = "#f9fbfb",
  B2T_D0 = "#289dbd",
  B2T_D1 = "#33abcc",
  B2T_D2 = "#4db0cb",
  B2T_D3 = "#5cbcd6",
  B2T_D4 = "#67c9e4",
  B2T_D5 = "#75d5f0",
  B2T_D6 = "#86e0f9",
  B2T_D7 = "#99e9ff",
}

local diagnostic_colors = {
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#67c9e4",
  Hint = "#10B981"
}


vim.api.nvim_create_augroup("colors", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
	group = "colors",
	pattern = "*",
	callback = function(opts)
    local ok, palette = pcall(require, opts.match .. ".palette")

    if not ok then return end

    utils.overwrite_hl_groups({
      NormalNC = { bg = palette.B2T_A0 },
      StatusLine = { bg = palette.B2T_A0 },
      SignColumn = { bg = none },
      FloatTitle = { fg = palette.B2T_A6, bg =  palette.B2T_A0},
      FloatBorder = { fg = palette.B2T_A4, bg = palette.B2T_A0 },

      Comment = { fg = palette.B2T_A6 },
      Type = { fg = palette.B2T_D1 },
      Todo = { fg = palette.B2T_D4 },
      ["@lsp.type.namespace"]= { fg = palette.B2T_D1 },
      ["@lsp.type.interface"]= { fg = palette.B2T_D1 },

      TelescopeMatching = { fg = palette.B2T_D3 },
      TelescopeResultsLineNr = { fg = palette.B2T_D3 },
      TelescopeResultsSpecialComment = { fg = palette.B2T_A5 },

      DiagnosticError = { fg = diagnostic_colors.Error },
      DiagnosticWarn = { fg = diagnostic_colors.Warning },
      DiagnosticInfo = { fg = diagnostic_colors.Information},
      DiagnosticHint = { fg = diagnostic_colors.Hint},

      DiagnosticSignError = { fg = diagnostic_colors.Error },
      DiagnosticSignWarn = { fg = diagnostic_colors.Warning },
      DiagnosticSignInfo = { fg = diagnostic_colors.Information},
      DiagnosticSignHint = { fg = diagnostic_colors.Hint},

      DiagnosticVirtualTextError = { fg = utils.darken(diagnostic_colors.Error, 0.8) },
      DiagnosticVirtualTextWarn = { fg = utils.darken(diagnostic_colors.Warning, 0.8) },
      DiagnosticVirtualTextInfo = { fg = utils.darken(diagnostic_colors.Information, 0.8) },
      DiagnosticVirtualTextHint = { fg = utils.darken(diagnostic_colors.Hint, 0.8) },

      ["@punctuation"] = { fg = palette.B2T_C3 },

      Pmenu = { bg = palette.B2T_A0 },
      PmenuSel = { bg = palette.B2T_A2 },
      PmenuThumb = { bg = palette.B2T_A2 },
      NormalFloat = { bg = palette.B2T_A0},

      diffAdded = { fg = utils.darken(diagnostic_colors.Hint, 0.8) },
      diffRemoved = { fg = utils.darken(diagnostic_colors.Error, 0.8) },

      fugitiveUntrackedHeading = { fg = palette.B2T_D1},
      fugitiveUnstagedHeading = { fg = palette.B2T_D1},
      GitSignsAdd = { bg = none, fg = utils.darken(diagnostic_colors.Hint, 0.8) },
      GitSignsDelete = { bg = none,fg = utils.darken(diagnostic_colors.Error, 0.8) },
      GitSignsChange = { bg = none,fg = utils.darken(diagnostic_colors.Information, 0.8) },

      NvimTreeNormal = { fg = palette.B2T_B5 },
      NvimTreeGitNew = { fg = utils.darken(diagnostic_colors.Hint, 0.8) },
      NvimTreeGitDirty = { fg = utils.darken(diagnostic_colors.Warning, 0.8) },
      NvimTreeGitDeleted = { fg = utils.darken(diagnostic_colors.Error, 0.8) },
      NvimTreeGitStaged = { fg = utils.darken(diagnostic_colors.Information, 0.8) },
    })

	end,
})
