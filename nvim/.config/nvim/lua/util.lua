local M = {}

M.functions = {}
-- map CMD on mac, Alt on linux
function M.map_cmd_alt(key)
  if vim.g.is_macos then
    return "<D-" .. key .. ">"
  else
    return "<A-" .. key .. ">"
  end
end

return M
