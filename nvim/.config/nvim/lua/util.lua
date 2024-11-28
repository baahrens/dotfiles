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

M.common_mappings = {
  open_vsplit = M.map_cmd_alt("CR"),
  select_next = M.map_cmd_alt("j"),
  select_prev = M.map_cmd_alt("k"),
  scroll_up = "<C-u>",
  scroll_down = "<C-d>",
}

return M
