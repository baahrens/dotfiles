local t_builtin = require("telescope.builtin")
local t_themes = require("telescope.themes")

local M = {}

function M.grep_notes()
  local note_dirs = { "tech" }
  if vim.g.is_work_machine then
    table.insert(note_dirs, "work")
  else
    table.insert(note_dirs, "private")
  end

  return t_builtin.grep_string(t_themes.get_dropdown({
    cwd = vim.g.notes_dir,
    search_dirs = note_dirs,
    prompt_title = "~ tech notes ~",
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
  local file_name = vim.g.notes_dir .. "/work/daily/" .. date .. ".md"
  vim.cmd("vsplit " .. file_name)
end

return M
