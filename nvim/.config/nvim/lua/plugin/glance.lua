local u = require("util")
local glance = require('glance')
local actions = glance.actions

glance.setup({
  height = 10,
  zindex = 45,
  preview_win_opts = {
    cursorline = true,
    number = true,
    wrap = true,
  },
  list = {
    position = 'right',
    width = 0.33,
  },
  theme = {
    enable = true,
    mode = 'auto',     -- 'brighten'|'darken'|'auto'
  },
  border = {
    enable = true
  },
  mappings = {
    list = {
      ['j'] = actions.next,
      ['k'] = actions.previous,
      ['<Down>'] = actions.next,
      ['<Up>'] = actions.previous,
      [u.map_cmd_alt("k")] = actions.previous_location,
      [u.map_cmd_alt("j")] = actions.next_location,
      ['<C-u>'] = actions.preview_scroll_win(5),
      ['<C-d>'] = actions.preview_scroll_win(-5),
      [u.map_cmd_alt("CR")] = actions.jump_vsplit,
      ['s'] = actions.jump_split,
      ['t'] = false,
      ['<CR>'] = actions.jump,
      ['o'] = actions.jump,
      ['<leader>l'] = actions.enter_win('preview'),
      ['q'] = actions.close,
      ['Q'] = actions.close,
      ['<Esc>'] = actions.close,
    },
    preview = {
      ['Q'] = actions.close,
      [u.map_cmd_alt("k")] = actions.previous_location,
      [u.map_cmd_alt("j")] = actions.next_location,
      ['<leader>l'] = actions.enter_win('list'),
    },
  },
  hooks = {},
  folds = {
    fold_closed = '',
    fold_open = '',
    folded = false,
  },
  indent_lines = {
    enable = true,
    icon = '│',
  },
  winbar = {
    enable = true,
  },
})
