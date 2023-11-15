local t_builtin = require("telescope.builtin")
local t_themes = require("telescope.themes")

local M = {}

function M.grep_tech()
  return t_builtin.grep_string(t_themes.get_dropdown({
    cwd = vim.g.notes_dir,
    search_dirs = { "tech", "work" },
    prompt_title = "~ tech notes ~",
    previewer = true,
  }))
end

function M.grep_private()
  return t_builtin.grep_string(t_themes.get_dropdown({
    cwd = vim.g.notes_dir,
    search_dirs = { "private" },
    prompt_title = "~ private notes ~",
    previewer = true,
  }))
end

function M.grep_daily()
  return t_builtin.grep_string(t_themes.get_dropdown({
    cwd = vim.g.notes_dir,
    search_dirs = { "work/daily" },
    prompt_title = "~ daily notes ~",
    previewer = true,
  }))
end

local daily_augroup = vim.api.nvim_create_augroup("Daily", {})
vim.api.nvim_create_autocmd("BufNewFile", {
  group = daily_augroup,
  pattern = vim.g.notes_dir .. "/work/daily/" .. "*.md",
  callback = function()
    local date = os.date("%A %d.%m.%Y")
    vim.cmd("0r " .. vim.g.template_dir .. "/daily.md")
    vim.cmd("s/{{DATE}}/" .. date .. "/")
    vim.cmd("3")
  end
})

function M.open_daily()
  local date = os.date("%d-%m-%Y")
  local file_name =  vim.g.notes_dir .. "/work/daily/" .. date .. ".md"
  vim.cmd("vsplit " .. file_name)
end

return M
