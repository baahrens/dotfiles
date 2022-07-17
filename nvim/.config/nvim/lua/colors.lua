
-- No idea why this does not work with onenords custom_highlights
vim.cmd[[
  fun! SetHighlights() abort
      highlight PMenu guibg=none
    endfun
    augroup Colors
      autocmd!
      autocmd ColorScheme * call SetHighlights()
  augroup END

  colorscheme onenord
]]
