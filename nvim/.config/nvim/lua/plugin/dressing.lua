local settings = require("settings")

require("dressing").setup({
  input = {
    enable = true,
    insert_only = false,
    win_options = {
      winblend = settings.winblend,
    },
    prompt_align = "left",
    border = settings.border,
    mappings = {
      n = {
        ["<Esc>"] = "Close",
        ["<CR>"] = "Confirm",
      },
      i = {
        ["<C-c>"] = "Close",
        ["<CR>"] = "Confirm",
        ["<Up>"] = "HistoryPrev",
        ["<Down>"] = "HistoryNext",
      },
    },
  },
  select = {
    enable = true,
    win_options = {
      winblend = settings.winblend,
    },
    border = settings.border,
    mappings = {
      ["<Esc>"] = "Close",
      ["<C-c>"] = "Close",
      ["<CR>"] = "Confirm",
    },
  },
})
