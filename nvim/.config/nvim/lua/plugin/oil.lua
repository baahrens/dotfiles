local mappings = require("mappings")
local settings = require("settings")
local actions = require("oil.actions")

require("oil").setup({
  default_file_explorer = true,
  skip_confirm_for_simple_edits = true,
  delete_to_trash = true,
  use_default_keymaps = false,
  view_options = {
    show_hidden = true,
  },
  columns = { { "icon", add_padding = true } },
  win_options = {
    wrap = false,
    signcolumn = "yes",
    cursorcolumn = false,
    foldcolumn = "0",
    spell = false,
    list = false,
    conceallevel = 3,
    concealcursor = "nvic",
  },
  float = {
    max_width = 50,
    win_options = {
      winblend = settings.winblend,
    },
    override = function(config)
      config.relative = "editor"
      config.col = vim.o.columns
      config.border = {
        "╭",
        "─",
        "",
        "",
        "",
        "",
        "",
        "│",
      }
      config.height = math.floor(vim.o.lines * 0.5)
      config.row = vim.o.lines / 2
      config.style = "minimal"
      return config
    end
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
    border = settings.border,
    minimized_border = "none",
    win_options = {
      winblend = settings.winblend,
    },
  },
  keymaps = {
    ["g?"] = actions.show_help,
    ["<CR>"] = actions.select,
    ["L"] = actions.select,
    ["<C-n>"] = actions.close,
    ["<C-b>"] = actions.close,
    [mappings.common.open_vsplit] = function()
      actions.select.callback({ vertical = true })
      actions.close.callback()
    end,
    ["q"] = actions.close,
    ["H"] = actions.parent,
    ["_"] = actions.open_cwd,
    ["`"] = actions.cd,
    ["~"] = actions.tcd,
    ["gs"] = actions.change_sort,
    ["gx"] = actions.open_external,
    ["g."] = actions.toggle_hidden,
  },
})
