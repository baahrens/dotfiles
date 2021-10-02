local tree_cb = require'nvim-tree.config'.nvim_tree_callback
local nvim_tree = require'nvim-tree'

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
  lsp_diagnostics = true,
  follow = true,
  git_hl = true,
  tree_bindings = {
    { key = "v", cb = tree_cb("vsplit") },
    { key = "s", cb = tree_cb("split") }
  },
  view = {
    width = 40,
    side = 'left',
  }
}

