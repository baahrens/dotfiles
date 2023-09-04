local M = {}

function M.overwrite_hl_groups(groups)
  for group, spec in pairs(groups) do
    vim.api.nvim_set_hl(0, group, spec)
  end
end


-- taken from folke/tokyonight.nvim
-- https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/util.lua
local function hexToRgb(c)
  c = string.lower(c)
  return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

function M.blend(foreground, background, alpha)
  alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
  local bg = hexToRgb(background)
  local fg = hexToRgb(foreground)

  local blendChannel = function(i)
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
end

function M.darken(hex, amount, bg)
  return M.blend(hex, bg or "#000000", amount)
end

function M.lighten(hex, amount, fg)
  return M.blend(hex, fg or M.fg, amount)
end


return M
