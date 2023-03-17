local actions = require'telescope.actions'

require'telescope'.setup({
  defaults = {
    color_devicons = false,
    file_ignore_patterns = {
      '%.jpg',
      '%.jpeg',
      '%.png',
      '%.svg',
      '%.otf',
      '%.ttf',
    },
    mappings = {
      i = {
        ["<C-t>"]      = require'trouble.providers.telescope'.open_with_trouble,
        ["<ESC>"]      = actions.close,
        ["<leader>ff"] = actions.close,                   -- Alacritty: CMD + p
        ["<leader>kk"] = actions.move_selection_previous, -- Alacritty: CMD + k
        ["<S-Tab>"]    = actions.move_selection_previous,
        ["<leader>jj"] = actions.move_selection_next,     -- Alacritty: CMD + j
        ["<Tab>"]      = actions.move_selection_next,
        ['<C-d>']      = actions.preview_scrolling_down,
        ['<C-u>']      = actions.preview_scrolling_up,
        ["<leader>ww"] = actions.file_vsplit,             -- Alacritty: CMD + <CR>
        ["<C-f>"]      = actions.to_fuzzy_refine,
        ["<leader>f;"] = function () end,
      }
    },
    prompt_prefix = " ",
    selection_caret = " ",
  },
})
