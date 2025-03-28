local M = {}

function M.setup()
  require("rose-pine").setup({
    variant = "moon",
    disable_italics = true,
    disable_background = false,
  })
end

return M
