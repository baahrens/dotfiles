local tsConfigs = require'nvim-treesitter.configs'

tsConfigs.setup {
  ensure_installed = "maintained",
  indent = {
    enable = false
  },
  autotag = {
    enable = true
  },
  highlight = {
    enable = true
  },

  -- textobjects = {
  --   select = {
  --     enable = true,
  --     keymaps = {
  --       ["af"] = "@function.outer",
  --       ["if"] = "@function.inner"
  --     }
  --   },
  --   swap = {
  --     enable = true,
  --     swap_next = {
  --       ["<leader>l"] = "@parameter.inner",
  --     },
  --     swap_previous = {
  --       ["<leader>h"] = "@parameter.inner",
  --     }
  --   }
  -- },

  ------- nvim development stuff
  -- query_linter = {
  --   enable = true,
  --   use_virtual_text = true,
  --   lint_events = {"BufWrite", "CursorHold"}
  -- },
  -- playground = {
  --   enable = true,
  --   updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
  --   keybindings = {
  --     toggle_query_editor = 'o',
  --     toggle_hl_groups = 'i',
  --     toggle_injected_languages = 't',
  --     toggle_anonymous_nodes = 'a',
  --     toggle_language_display = 'I',
  --     focus_language = 'f',
  --     unfocus_language = 'F',
  --     update = 'R',
  --     goto_node = '<cr>',
  --     show_help = '?',
  --   }
  -- },
  -- incremental_selection = {
  --   enable = true,
  --   keymaps = {
  --     init_selection = "gnn",
  --     node_incremental = "grn",
  --     scope_incremental = "grc",
  --     node_decremental = "grm",
  --   }
  -- }
}

