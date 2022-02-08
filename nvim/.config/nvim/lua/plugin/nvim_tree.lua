local nvim_tree = require'nvim-tree'

vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.DS_Store' }

vim.g.nvim_tree_icons = {
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
}

nvim_tree.setup {
  auto_close = true,
  update_cwd = true,
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_to_buf_dir   = {
    enable = true,
    auto_open = true,
  },
  view = {
    width = 40,
    side = "left",
    mappings = {
      list = {
        { key = "v", action = "vsplit" },
        { key = "s", action = "split" },
        { key = "x", action = "close_node" }
      }
    }
  }
}

