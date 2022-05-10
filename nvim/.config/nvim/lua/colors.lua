vim.cmd[[
  fun! SetHighlights() abort
    highlight TelescopeNormal guibg=none
  endfun

  augroup Colors
    autocmd!
    autocmd ColorScheme * call SetHighlights()
  augroup END

  colorscheme onenord
]]
