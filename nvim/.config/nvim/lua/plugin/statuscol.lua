local builtin = require("statuscol.builtin")

require("statuscol").setup({
  setopt = true,
  relculright = true,
  ft_ignore = {
    "^git.*",
    "fugitive",
    "noice",
    "oil",
    "TelescopePrompt",
    "TelescopeResults",
    "OverseerForm",
    "OverseerList",
  },
  segments = {
    { text = { "  " }},
    {
      text = { builtin.lnumfunc, " " },
      condition = { true, builtin.not_empty },
    },
    { text = { "%s " }, condition = { true } },
  },
})
