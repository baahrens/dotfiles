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
          winhighlight = {
            Normal = 'LspFloat',
            FloatBorder = 'CmpBorder',
          },
        }
      }
    },
    signature = {
      enabled = true,
      auto_open = {
        enabled = true,
        trigger = true,
        luasnip = true,
        throttle = 50,
      },
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
          winhighlight = {
            Normal = 'LspFloat',
            FloatBorder = 'CmpBorder',
          },
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
    popupmenu = {
      backend = "cmp",
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
        style = "rounded",
        padding = { 0, 1 },
      },
      win_options = {
        winhighlight = { Normal = "NormalFloat", FloatBorder = "FloatBorder" },
      },
    },
    mini = {
      win_options = {
        winblend = 0
      }
    },
  },
})
