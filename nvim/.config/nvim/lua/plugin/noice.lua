local settings = require("settings")
require('noice.util.hacks').fix_cmp()

require("noice").setup({
  lsp = {
    progress = {
      enabled = true,
    },
    hover = {
      enabled = true,
      opts = {
        border = { style = settings.border },
        relative = 'cursor',
        position = {
          row = 2,
        },
        win_options = {
          concealcursor = 'n',
          conceallevel = 3,
        }
      }
    },
    signature = {
      enabled = true,
      view = "hover",
      opts = {
        border = { style = settings.border },
        relative = 'cursor',
        position = {
          row = 2,
        },
        win_options = {
          concealcursor = 'n',
          conceallevel = 3,
        }
      }
    }
  },
  routes = {
    {
      filter = { event = "msg_show", kind = "search_count" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", kind = "", find = "written" },
      opts = { skip = true },
    },
  },
  notify = {
    enabled = false,
  },
  views = {
    cmdline_popup = {
      position = {
        row = 5,
        col = "50%",
      },
      size = {
        width = 60,
        height = "auto",
      }
    },
    popupmenu = {
        relative = "editor",
        position = {
          row = 8,
          col = "50%",
        },
        size = {
          width = 60,
          height = 10,
        },
        border = {
          style = settings.border,
          padding = { 0, 1 },
        },
      },
    mini = {
      win_options = {
        winblend = settings.winblend
      }
    },
  },
})
