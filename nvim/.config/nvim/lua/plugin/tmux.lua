require("tmux").setup({
  copy_sync = {
    enable = true,
    sync_clipboard = true,
  },
  navigation = {
    cycle_navigation = true,
    enable_default_keybindings = true,
    persist_zoom = false,
  },
  resize = {
    enable_default_keybindings = false,
  }
})
