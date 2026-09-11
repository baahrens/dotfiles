local u = require("util")

require("blink.cmp").setup({
  signature = { enabled = true, window = { border = "rounded" } },
  snippets = { preset = "luasnip" },
  keymap = {
    preset = "super-tab",
    [u.common_mappings.scroll_up] = { "scroll_documentation_up", "fallback" },
    [u.common_mappings.scroll_down] = { "scroll_documentation_down", "fallback" },
    ["<C-s>"] = { "hide", "fallback" },
    ["<CR>"] = { "select_and_accept", "fallback" },
    [u.common_mappings.select_prev] = { "select_prev", "fallback" },
    [u.common_mappings.select_next] = { "select_next", "fallback" },
  },

  appearance = {
    nerd_font_variant = "mono",
  },

  completion = {
    menu = { border = "rounded" },
    documentation = { window = { border = "rounded" }, auto_show = true },
  },

  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  cmdline = {
    keymap = {
      ["<Tab>"] = { "accept" },
      [u.common_mappings.select_prev] = { "select_prev", "fallback" },
      [u.common_mappings.select_next] = { "select_next", "fallback" },
    },
    completion = {
      menu = {
        auto_show = true,
      },
    },
  },

  fuzzy = { implementation = "prefer_rust_with_warning" },
})
