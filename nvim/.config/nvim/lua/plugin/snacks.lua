local u = require("util")

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
  picker = {
    layout = { preset = "ivy_split" },
    matcher = {
      frecency = true,
    },
    win = {
      input = {
        keys = {
          [u.common_mappings.select_prev] = { "list_up", mode = { "i", "n" } },
          [u.common_mappings.select_next] = { "list_down", mode = { "i", "n" } },
          [u.common_mappings.open_vsplit] = { "edit_vsplit", mode = { "i", "n" } },
          [u.map_cmd_alt("p")] = { "cancel", mode = { "i", "n" } },
          [u.common_mappings.scroll_down] = { "preview_scroll_down", mode = { "i", "n" } },
          [u.common_mappings.scroll_up] = { "preview_scroll_up", mode = { "i", "n" } },
        },
      },
    },
  },
})
