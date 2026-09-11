local u = require("util")

require("snacks").setup({
  bigfile = { enabled = true },
  indent = {
    enabled = true,
    indent = { hl = "FloatBorder" },
    scope = { enabled = true, only_current = true },
    animate = { enabled = false },
  },
  input = { enabled = true },
  quickfile = { enabled = true },
  picker = {
    layout = { preset = "ivy" },
    matcher = {
      frecency = true,
    },
    win = {
      input = {
        keys = {
          ["<Esc>"] = { "close", mode = { "n", "i" } },
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
