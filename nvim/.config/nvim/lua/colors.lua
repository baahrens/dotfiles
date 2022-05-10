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

-- vim.g.nord_borders = true
-- vim.g.nord_disable_background = true
-- vim.g.nord_italic = false

-- vim.g.rose_pine_variant = 'moon'
-- vim.g.rose_pine_enable_italics = false
-- vim.g.rose_pine_disable_background = true

vim.cmd[[
  fun! SetHighlights() abort
    highlight JsxExpressionBlock guifg=#e0af68

    highlight CursorLineNr guifg=#e0af68

    highlight Search gui=bold guifg=#EBCB8B guibg=#4C566A

    highlight HlSearchNear guifg=#88C0D0
    highlight HlSearchLens guifg=#88C0D0
    highlight HlSearchLensNear guifg=#88C0D0
    highlight HlSearchFloat guifg=#88C0D0
    highlight TelescopeNormal guibg=none
  endfun

  augroup Colors
    autocmd!
    autocmd ColorScheme * call SetHighlights()
  augroup END

  colorscheme onenord
]]
