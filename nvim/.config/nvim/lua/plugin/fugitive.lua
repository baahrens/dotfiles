local M = {}

local split_width = 80

local function resize_split()
  vim.cmd(string.format("vertical resize %s", split_width))
end

function M.git_status()
  vim.cmd("vertical Git")
  resize_split()
end

function M.git_log()
  vim.cmd("vertical Git log")
  resize_split()
end

return M
