local settings = require("settings")

require("mason").setup({
    PATH = "skip",
  ui = {
    border = settings.border,
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})
