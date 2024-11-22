local default_config = {
  layout_config = { height = 0.4 }
}
local function get_current_theme(options)
  local opts = vim.tbl_deep_extend("force", default_config, options or {})
  return require("telescope.themes").get_ivy(opts)
end

local M = {}

function M.find_files(cwd)
  require("telescope").extensions.smart_open.smart_open(
    get_current_theme({
      prompt_title = "files",
      cwd_only = true,
      filename_first = false,
      cwd = cwd or vim.fn.getcwd()
    })
  )
end

function M.live_grep(cwd)
  require("telescope.builtin").live_grep(
    get_current_theme({ prompt_title = "grep", cwd = cwd or vim.fn.getcwd() })
  )
end

function M.help()
  require("telescope.builtin").help_tags(
    get_current_theme({ prompt_title = "help" })
  )
end

function M.mappings()
  require("telescope.builtin").keymaps(
    get_current_theme({ prompt_title = "mappings" })
  )
end

function M.commands()
  require("telescope.builtin").commands(
    get_current_theme({ prompt_title = "commands" })
  )
end

function M.highlights()
  require("telescope.builtin").highlights(
    get_current_theme({ prompt_title = "highlights" })
  )
end

function M.buffer()
  require("telescope.builtin").buffers(
    get_current_theme({ prompt_title = "buffer" })
  )
end

function M.current_buffer()
  require("telescope.builtin").current_buffer_fuzzy_find(
    get_current_theme({ prompt_title = "fuzzy" })
  )
end

function M.branches()
  require("telescope.builtin").git_branches(
    get_current_theme({ prompt_title = "branches" })
  )
end

function M.diagnostics()
  require("telescope.builtin").diagnostics(
    get_current_theme({ prompt_title = "diagnostics" })
  )
end

function M.resume()
  require("telescope.builtin").resume(get_current_theme())
end

function M.old_files()
  require("telescope.builtin").oldfiles(get_current_theme())
end

return M
