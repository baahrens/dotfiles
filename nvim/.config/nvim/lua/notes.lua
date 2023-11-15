local t_builtin = require("telescope.builtin")
local t_themes = require("telescope.themes")

local TEMPLATE_DIR = "~/.dotfiles/nvim/.config/nvim/templates"
local NOTES_DIR = "~/notes"
local DAILY_DIR = "~/notes/work/daily"

local M = {}

function M.grep_tech()
  return t_builtin.grep_string(t_themes.get_dropdown({
    cwd = NOTES_DIR,
    search_dirs = { "tech", "work" },
    prompt_title = "~ tech notes ~",
    previewer = true,
  }))
end

function M.grep_private()
  return t_builtin.grep_string(t_themes.get_dropdown({
    cwd = NOTES_DIR,
    search_dirs = { "private" },
    prompt_title = "~ private notes ~",
    previewer = true,
  }))
end

function M.grep_daily()
  return t_builtin.grep_string(t_themes.get_dropdown({
    cwd = NOTES_DIR,
    search_dirs = { "work/daily" },
    prompt_title = "~ daily notes ~",
    previewer = true,
  }))
end

local daily_augroup = vim.api.nvim_create_augroup("Daily", {})
vim.api.nvim_create_autocmd("BufNewFile", {
  group = daily_augroup,
  pattern = vim.fn.expand("~") .. DAILY_DIR .. "*.md",
  callback = function()
    local date = os.date("%A %d.%m.%Y")
    vim.cmd("0r " .. TEMPLATE_DIR .. "/daily.md")
    vim.cmd("s/{{DATE}}/" .. date .. "/")
    vim.cmd("3")
  end
})

function M.open_daily()
  local date = os.date("%d-%m-%Y")
  local file_name = DAILY_DIR .. "/" .. date .. ".md"
  vim.cmd("vsplit " .. file_name)
end

return M
