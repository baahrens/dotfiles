local actions = require("oil.actions")
require("oil").setup({
  default_file_explorer = true,
  skip_confirm_for_simple_edits = true,
  delete_to_trash = true,
  view_options = {
    show_hidden = true,
  },
  win_options = {
    wrap = false,
    signcolumn = "no",
    cursorcolumn = false,
    foldcolumn = "0",
    spell = false,
    list = false,
    conceallevel = 3,
    concealcursor = "nvic",
  },
  buf_options = {
    buflisted = false,
    bufhidden = "hide",
  },
  progress = {
    max_width = 0.9,
    min_width = { 40, 0.4 },
    width = nil,
    max_height = { 10, 0.9 },
    min_height = { 5, 0.1 },
    height = nil,
    border = "rounded",
    minimized_border = "none",
    win_options = {
      winblend = 0,
    },
  },
  use_default_keymaps = false,
  keymaps = {
    ["g?"] = actions.show_help,
    ["<CR>"] = actions.select,
    ["L"] = actions.select,
    ["<C-s>"] = function()
      actions.select.callback({ vertical = true })
      actions.close.callback()
    end,
    ["K"] = actions.preview,
    ["<C-n>"] = actions.close,
    ["<C-b>"] = actions.close,
    ["H"] = actions.parent,
    ["_"] = actions.open_cwd,
    ["`"] = actions.cd,
    ["~"] = actions.tcd,
    ["gs"] = actions.change_sort,
    ["gx"] = actions.open_external,
    ["g."] = actions.toggle_hidden,
  },
})
