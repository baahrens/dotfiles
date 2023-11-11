require("cybu").setup({
  position = {
    relative_to = "win",
    anchor = "topright"
  },
  behavior = {
    mode = {
      last_used = {
        switch = "immediate",
        view = "rolling"
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
    "oil",
    "fugitive",
  },
})
