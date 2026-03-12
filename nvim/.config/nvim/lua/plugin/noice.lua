local settings = require("settings")

require("noice").setup({
  lsp = {
    progress = {
      enabled = false,
    },
    hover = {
      enabled = false,
    },
    signature = {
      enabled = false,
    },
  },
  routes = {
    {
      view = "virtualtext",
      filter = {
        event = "msg_showmode",
        any = {
          { find = "recording" },
        },
      },
    },
    {
      filter = { event = "msg_show", kind = "search_count" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", kind = "", find = "written" },
      opts = { skip = true },
    },
  },
  cmdline = {
    view = "cmdline"
  },

  presets = {
    bottom_search = true,
    command_palette = false,
    inc_rename = false,
    lsp_doc_border = false
  },
  notify = {
    enabled = false,
  },
  views = {
    mini = {
      win_options = {
        winblend = settings.winblend,
      },
    },
  },
})
