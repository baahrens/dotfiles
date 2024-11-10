local M = {}

function M.setup()
  require('poimandres').setup {
    dim_nc_background = false
  }
end

return M
