vim.g.nvim_tree_width = 40
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.DS_Store' }
vim.g.nvim_tree_quit_on_open = 1
vim.g.vim_tree_lsp_diagnostics = 1
vim.g.nvim_tree_special_files = {
  ['package.json'] = 1,
  ['index.js'] = 1,
  ['init.lua'] = 1
}
vim.g.nvim_tree_show_icons = {
  ['git'] = 1,
  ['folders'] = 1,
  ['files'] = 0,
  ['folder_arrows'] = 1
}

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
vim.g.nvim_tree_bindings = {
  { key = "v", cb = tree_cb("vsplit") },
  { key = "s", cb = tree_cb("split") }
}

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
