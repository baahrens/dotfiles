require("snacks").setup({
  bigfile = { enabled = true },
  dashboard = {
    enabled = true,
    sections = {
      { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1, cwd = true },
    },
  },
  indent = {
    enabled = true,
    indent = { hl = "FloatBorder" },
    scope = { enabled = true, only_current = true },
    animate = { enabled = false },
  },
  input = { enabled = true },
  quickfile = { enabled = true },
})
