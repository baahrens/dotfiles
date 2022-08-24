local nvim_tree = require'nvim-tree'

nvim_tree.setup {
  update_cwd = true,
  actions = {
    open_file = {
      quit_on_open = true,
    }
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  view = {
    width = 50,
    side = "right",
    mappings = {
      list = {
        { key = "v", action = "vsplit" },
        { key = "s", action = "split" },
        { key = "x", action = "close_node" }
      }
    }
  },
  renderer = {
    indent_markers = {
      enable = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        none = " ",
      },
    },
    special_files = { "package.json", "Cargo.toml", "index.js", "index.ts", "init.lua", "main.rs", "index.tsx", "index.jsx" },
    icons = {
      webdev_colors = false ,
      git_placement = "after",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌"
        },
        folder = {
          arrow_open = "",
          arrow_closed = "",
          default = "",
          open = "",
          empty = "", -- 
          empty_open = "",
          symlink = "",
          symlink_open = ""
        }
      },
    },
  }
}

