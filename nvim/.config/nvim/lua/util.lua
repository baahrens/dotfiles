local M = {}

M.functions = {}

function M.execute(id)
  local func = M.functions[id]
  if not func then
    error("Function doest not exist: " .. id)
  end
  return func()
end

local map = function(mode, key, cmd, opts, defaults)
  opts = vim.tbl_deep_extend("force", { silent = true }, defaults or {}, opts or {})

  if type(cmd) == "function" then
    table.insert(M.functions, cmd)
    if opts.expr then
      cmd = ([[luaeval('require("util").execute(%d)')]]):format(#M.functions)
    else
      cmd = ("<cmd>lua require('util').execute(%d)<cr>"):format(#M.functions)
    end
  end
  if opts.buffer ~= nil then
    local buffer = opts.buffer
    opts.buffer = nil
    return vim.api.nvim_buf_set_keymap(buffer, mode, key, cmd, opts)
  else
    return vim.api.nvim_set_keymap(mode, key, cmd, opts)
  end
end

function M.remap(mode, key, cmd, opt, defaults)
  return map(mode, key, cmd, opt, defaults)
end

-- map CMD on mac, Alt on linux
function M.map_cmd_alt(key)
  if vim.g.is_macos then
    return "<D-" .. key .. ">"
  else
    return "<A-" .. key .. ">"
  end
end

return M
