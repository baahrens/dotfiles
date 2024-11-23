local M = {}

local split_width = 80

--- Ask user to confirm an action
---@param prompt string: The prompt for confirmation
---@param default_value string: The default value of user input
---@param yes_values table: List of positive user confirmations ({"y", "yes"} by default)
---@return boolean: Whether user confirmed the prompt
local function ask_to_confirm(prompt, default_value, yes_values)
  yes_values = yes_values or { "y", "yes" }
  default_value = default_value or ""
  local confirmation = vim.fn.input(prompt, default_value)
  confirmation = string.lower(confirmation)
  if string.len(confirmation) == 0 then
    return false
  end
  for _, v in pairs(yes_values) do
    if v == confirmation then
      return true
    end
  end
  return false
end

local function resize_split()
  vim.cmd(string.format("vertical resize %s", split_width))
end

function M.status()
  vim.cmd("vertical Git")
  resize_split()
end

function M.log()
  vim.cmd("vertical Git log")
  resize_split()
end

function M.new_branch()
  vim.ui.input({ prompt = "Branchname: " }, function(input)
    if input then
      vim.cmd(string.format("Git switch -c %s", input))
    end
  end)
end

function M.reset_hard()
  if ask_to_confirm("Reset hard?", "", {}) then
    vim.cmd("Git reset origin/master --hard")
  end
end

return M
