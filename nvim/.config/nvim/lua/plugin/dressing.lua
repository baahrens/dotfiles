require('dressing').setup({
  input = {
    enable = true,
    win_options = {
      winblend = 0,
    },
    prompt_align = "left",
    border = "rounded",
    anchor = "NW",
    mappings = {
      n = {
        ['<Esc>'] = 'Close',
        ['<CR>'] = 'Confirm',
      },
      i = {
        ['<C-c>'] = 'Close',
        ['<CR>'] = 'Confirm',
        ['<Up>'] = 'HistoryPrev',
        ['<Down>'] = 'HistoryNext',
      },
    },
  },
  select = {
    enable = true,
    win_options = {
      winblend = 0,
    },
    border = "rounded",
    mappings = {
      ['<Esc>'] = 'Close',
      ['<C-c>'] = 'Close',
      ['<CR>'] = 'Confirm',
    },
  },
})
