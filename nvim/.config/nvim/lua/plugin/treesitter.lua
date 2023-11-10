require("nvim-treesitter.configs").setup({
  highlight = { enable = true },
  matchup = { enable = true },
  autotag = {
    enable = true,
    enable_close_on_slash = false,
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["as"] = "@statement.outer",
      },
    },
  },
  playground = {
    enable = false,
    updatetime = 25,
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>",
      show_help = "?",
    },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-S>",
      node_incremental = "<C-S>",
      scope_incremental = "grc",
      node_decremental = "<C-X>",
    },
  },
})
