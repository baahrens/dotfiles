local u = require("util")

require("blink.cmp").setup({
  signature = { enabled = true, window = { border = "rounded" } },
  snippets = { preset = "luasnip" },
  -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
  -- 'super-tab' for mappings similar to vscode (tab to accept)
  -- 'enter' for enter to accept
  -- 'none' for no mappings
  --
  -- All presets have the following mappings:
  -- C-space: Open menu or open docs if already open
  -- C-n/C-p or Up/Down: Select next/previous item
  -- C-e: Hide menu
  -- C-k: Toggle signature help (if signature.enabled = true)
  --
  -- See :h blink-cmp-config-keymap for defining your own keymap
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

  -- Default list of enabled providers defined so that you can extend it
  -- elsewhere in your config, without redefining it, due to `opts_extend`
  sources = {
    default = { "lsp", "path", "snippets", "buffer", "copilot" },
    providers = {
      copilot = {
        name = "copilot",
        module = "blink-copilot",
        score_offset = 100,
        async = true,
      },
    },
  },
  cmdline = {
    keymap = {
      ["<Tab>"] = { "accept" },
      ["<CR>"] = { "accept_and_enter", "fallback" },
      [u.common_mappings.select_prev] = { "select_prev", "fallback" },
      [u.common_mappings.select_next] = { "select_next", "fallback" },
    },
    completion = {
      menu = {
        auto_show = true,
      },
    },
  },

  -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
  -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
  -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
  --
  -- See the fuzzy documentation for more information
  fuzzy = { implementation = "prefer_rust_with_warning" },
})
