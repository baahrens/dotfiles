local settings = require("settings")

require("cybu").setup({
  position = {
    relative_to = "win",
    anchor = "center"
  },
  behavior = {
    mode = {
      last_used = {
        switch = "immediate",
        view = "paging"
      },
    }
  },
  style = {
    path = "relative",
    path_abbreviation = "shortened",
    padding = 4,
    hide_buffer_id = true,
    border = settings.border,
  },
  display_time = 700,
  exclude = {
    "oil",
    "fugitive",
  },
})
