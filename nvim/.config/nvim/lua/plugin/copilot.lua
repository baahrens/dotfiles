local u = require("util")

require("copilot").setup({
  suggestion = {
    enabled = true,
    auto_trigger = true,
    keymap = {
      accept = "<C-f>",
      next = u.map_cmd_alt("f"),
    },
  },
  server_opts_overrides = {
    settings = {
      advanced = {
        debug = {
          acceptSelfSignedCertificate = true,
        },
      },
    },
  },
})
