local builtin = require("statuscol.builtin")

require("statuscol").setup({
  setopt = true,
  relculright = true,
  ft_ignore = { "oil" },
  segments = {
    { text = { "%s" } },
    { text = { "%C" } },
    {
      text = { builtin.lnumfunc, " " },
      condition = { true, builtin.not_empty },
    },
    { text = { "  " } },
  },
})
