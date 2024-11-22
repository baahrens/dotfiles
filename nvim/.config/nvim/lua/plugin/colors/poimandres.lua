local M = {}

function M.setup()
  require("poimandres").setup({
    dim_nc_background = false,
  })
end

M.highlight_overwrites = {
  TelescopePreviewTitle = { fg = "none" },
}

return M
