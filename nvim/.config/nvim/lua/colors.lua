-- vim.g.material_style = 'palenight'
-- vim.g.material_italic_keywords = true
-- vim.g.material_disable_background = true
-- vim.cmd[[colorscheme material]]

-- vim.g.tokyonight_transparent = 1
-- vim.cmd[[colorscheme tokyonight]]

-- vim.g.gruvbox_transparent_bg = 1
-- vim.g.gruvbox_bold = 0
-- vim.g.gruvbox_undercurl = 0
-- vim.g.gruvbox_italic = 0
-- vim.cmd[[colorscheme gruvbox]]

vim.g.nord_borders = true
vim.g.nord_disable_background = true
vim.g.nord_italic = false

-- vim.g.rose_pine_variant = 'moon'
-- vim.g.rose_pine_enable_italics = false
-- vim.g.rose_pine_disable_background = true
vim.cmd[[
  fun! SetHighlights() abort
    highlight JsxExpressionBlock guifg=#e0af68

    highlight CursorLineNr guifg=#e0af68

    highlight Search gui=bold guifg=#EBCB8B guibg=#4C566A

    highlight CmpItemKindText guifg=#5E81AC
    highlight CmpItemKindMethod guifg=#5E81AC
    highlight CmpItemKindFunction guifg=#5E81AC
    highlight CmpItemKindConstructor guifg=#5E81AC
    highlight CmpItemKindField guifg=#5E81AC
    highlight CmpItemKindVariable guifg=#88C0D0
    highlight CmpItemKindClass guifg=#5E81AC
    highlight CmpItemKindInterface guifg=#5E81AC
    highlight CmpItemKindValue guifg=#5E81AC
    highlight CmpItemKindKeyword guifg=#5E81AC
    highlight CmpItemKindSnippet guifg=#A3BE8C
    highlight CmpItemKindFile guifg=#5E81AC
    highlight CmpItemKindFolder guifg=#5E81AC

    highlight CmpItemAbbrMatch guifg=#D8DEE9
    highlight CmpItemAbbr guifg=#c1c9d6

    highlight HlSearchNear guifg=#88C0D0
    highlight HlSearchLens guifg=#88C0D0
    highlight HlSearchLensNear guifg=#88C0D0
    highlight HlSearchFloat guifg=#88C0D0
  endfun

  fun! SetNvimHighlights() abort
    highlight NvimTreeFolderName guifg=#81A1C1
    highlight NvimTreeEmptyFolderName guifg=#5E81AC
    highlight NvimTreeNormal guifg=#B0C9FF guibg=none
    highlight NvimTreeGitNew guifg=#EBCB8B
    highlight NvimTreeGitDirty guifg=#EBCB8B
    highlight NvimTreeOpenedFolderName guifg=#B0C9FF gui=bold
    highlight NvimTreeSpecialFile gui=none guifg=#cee7ff
  endfun

  augroup Colors
    autocmd!
    autocmd ColorScheme * call SetHighlights()
  augroup END

  augroup NvimTree
    autocmd!
    autocmd BufEnter NvimTree call SetNvimHighlights()
  augroup end

  colorscheme nord
]]

vim.cmd [[]]

--   colorscheme rose-pine

-- Nord colors
-- "#2E3440"
-- "#3B4252"
-- "#434C5E"
-- "#4C566A"
-- "#616E88"
-- "#D8DEE9"
-- "#E5E9F0"
-- "#ECEFF4"
-- "#8FBCBB"
-- "#88C0D0"
-- "#81A1C1"
-- "#5E81AC"
-- "#BF616A"
-- "#D08770"
-- "#EBCB8B"
-- "#A3BE8C"
-- "#B48EAD"
-- '#2E3440'
-- '#3B4252'
-- '#D8DEE9'
-- '#D8DEE9'
-- '#4C566A'
-- '#3B4252'
-- '#434C5E'
-- '#5E81AC'
-- '#434C5E'
-- '#616E88'
-- '#c1c9d6'
-- '#3B4252'
-- '#E5E9F0'
-- '#D8DEE9'
