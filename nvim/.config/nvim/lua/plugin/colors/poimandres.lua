local M = {}

function M.setup()
  require("poimandres").setup({
    dim_nc_background = false,
  })
end

M.highlight_overwrites = {
  ColorColumn = { bg = "#21212b" },
}

return M
