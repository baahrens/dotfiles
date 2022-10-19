require("cybu").setup({
  position = {
    relative_to = "win",
    anchor = "topright"
  },
  behavior = {
    mode = {
      default = {
        switch = "immediate",
        view = "paging"
      },
      last_used = {
        switch = "immediate",
        view = "paging"
      },
    }
  },
  style = {
    padding = 4,
    hide_buffer_id = true,
    border = "rounded"
  },
  display_time = 700,
  exclude = {
    "nvim-tree",
    "fugitive",
    "trouble"
  },
})
