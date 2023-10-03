require('noice.util.hacks').fix_cmp()

require("noice").setup({
  lsp = {
    progress = {
      enabled = true,
    },
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
    hover = {
      enabled = true,
      opts = {
        border = { style = 'rounded' },
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
        border = { style = 'rounded' },
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
      view = "notify",
      filter = { event = "msg_showmode" },
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
    mini = {
      win_options = {
        winblend = 0
      }
    },
  },
})
