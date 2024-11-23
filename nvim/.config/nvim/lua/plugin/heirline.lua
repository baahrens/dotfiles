local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local settings = require("settings")

local excluded_filetypes = {
  "^git.*",
  "fugitive",
  "noice",
  "oil",
  "TelescopePrompt",
  "TelescopeResults",
  "OverseerForm",
  "OverseerList",
}

local excluded_buftypes = {
  "nofile",
  "prompt",
  "help",
  "quickfix",
  "terminal",
}

local function setup_colors()
  local bg = utils.get_highlight("Normal").bg or "none"
  return {
    gray = utils.get_highlight("Identifier").fg,
    primary = utils.get_highlight("Keyword").fg,
    background = bg,
    background_nc = utils.get_highlight("NormalNC").bg or bg,
    diag_warn = utils.get_highlight("DiagnosticWarn").fg,
    diag_error = utils.get_highlight("DiagnosticError").fg,
    diag_hint = utils.get_highlight("DiagnosticHint").fg,
    diag_info = utils.get_highlight("DiagnosticInfo").fg,
    git_del = utils.get_highlight("GitSignsDelete").fg,
    git_add = utils.get_highlight("GitSignsAdd").fg,
    git_change = utils.get_highlight("GitSignsChange").fg,
  }
end

local align = { provider = "%=" }
local space = { provider = "   " }
local left_padding = { provider = "     " }

local file_icon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self)
    return self.icon and (self.icon .. " ")
  end,
}

local file_name = {
  provider = function(self)
    local filename = vim.fn.fnamemodify(self.filename, ":.")
    if filename == "" then
      return ""
    end
    if not conditions.width_percent_below(#filename, 0.25) then
      filename = vim.fn.pathshorten(filename)
    end
    return filename
  end,
}

local FileFlags = {
  {
    provider = function()
      if vim.bo.modified then
        return " 󰣕 "
      end
    end,
    hl = { fg = "diag_warn" },
  },
  {
    provider = function()
      if (not vim.bo.modifiable) or vim.bo.readonly then
        return "  "
      end
    end,
    hl = { fg = "diag_error" },
  },
}

local file_name_modifier = {
  hl = function()
    if vim.bo.modified then
      return { fg = "diag_warn", bold = true, force = true }
    end
  end,
}

local file_name_block = utils.insert({
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
  hl = function()
    if conditions.is_active() then
      return { fg = "primary" }
    else
      return { fg = "gray" }
    end
  end,
}, file_icon, utils.insert(file_name_modifier, file_name), unpack(FileFlags), { provider = "%<" }, space)

local ruler = {
  -- %l = current line number
  -- %L = number of lines in the buffer
  -- %c = column number
  -- %P = percentage through file of displayed window
  provider = " %l/%3L%: %2c %P",
  hl = { fg = "gray" },
}

local diagnostics = {
  condition = conditions.has_diagnostics,

  static = {
    hint_icon = settings.diagnostics.signs.Hint,
    info_icon = settings.diagnostics.signs.Info,
    warn_icon = settings.diagnostics.signs.Warn,
    error_icon = settings.diagnostics.signs.Error,
  },

  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,

  {
    provider = function(self)
      return self.errors > 0 and (self.error_icon .. " " .. self.errors .. " ")
    end,
    hl = { fg = "diag_error" },
  },
  {
    provider = function(self)
      return self.warnings > 0 and (self.warn_icon .. " " .. self.warnings .. " ")
    end,
    hl = { fg = "diag_warn" },
  },
  {
    provider = function(self)
      return self.info > 0 and (self.info_icon .. " " .. self.info .. " ")
    end,
    hl = { fg = "diag_info" },
  },
  {
    provider = function(self)
      return self.hints > 0 and (self.hint_icon .. " " .. self.hints)
    end,
    hl = { fg = "diag_hint" },
  },
}

local branch_name = {
  condition = conditions.is_git_repo,

  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
  end,

  {
    provider = function(self)
      return " " .. self.status_dict.head
    end,
    hl = { bold = true, fg = "diag_info" },
  },
}

local git_status = {
  condition = conditions.is_git_repo,

  init = function(self)
    self.added = vim.b.gitsigns_status_dict.added or 0
    self.removed = vim.b.gitsigns_status_dict.removed or 0
    self.changed = vim.b.gitsigns_status_dict.changed or 0
  end,

  {
    provider = function(self)
      return self.added > 0 and (" 󰐕 " .. self.added)
    end,
    hl = { fg = "git_add" },
  },
  {
    provider = function(self)
      return self.removed > 0 and (" 󰍴 " .. self.removed)
    end,
    hl = { fg = "git_del" },
  },
  {
    provider = function(self)
      return self.changed > 0 and (" 󰜥 " .. self.changed)
    end,
    hl = { fg = "git_change" },
  },
}

local work_dir = {
  provider = function()
    local cwd = vim.fn.getcwd(0)
    cwd = vim.fn.fnamemodify(cwd, ":~")
    if not conditions.width_percent_below(#cwd, 0.25) then
      cwd = vim.fn.pathshorten(cwd)
    end
    local trail = cwd:sub(-1) == "/" and "" or "/"
    return "󰉋 " .. cwd .. trail
  end,
  hl = { fg = "gray" },
}

local function clean_task_name(task_name)
  return string.gsub(task_name, "yarn run", "")
end

local function overseer_running()
  return {
    condition = function(self)
      return #self.running_tasks > 0
    end,
    provider = function(self)
      local running_task_names = {}
      for _, task in ipairs(self.running_tasks) do
        local task_name = clean_task_name(task.name)
        table.insert(running_task_names, task_name)
      end

      local running_tasks = table.concat(running_task_names, " - ")
      return string.format(" %s  ", running_tasks)
    end,
    hl = function()
      return {
        fg = "diag_info",
      }
    end,
  }
end
local function overseer_status(status)
  return {
    condition = function(self)
      return self.tasks[status]
    end,
    provider = function(self)
      return string.format("%s%d  ", self.symbols[status], #self.tasks[status])
    end,
    hl = function()
      local icon_color = status == "CANCELED" and "diag_warn"
        or status == "RUNNING" and "diag_info"
        or status == "SUCCESS" and "diag_hint"
        or "diag_error"
      return {
        fg = icon_color,
      }
    end,
  }
end

local overseer = {
  condition = function()
    return package.loaded.overseer
  end,
  init = function(self)
    local tasks = require("overseer.task_list").list_tasks({ unique = true })
    local tasks_by_status = require("overseer.util").tbl_group_by(tasks, "status")
    self.tasks = tasks_by_status
    self.running_tasks =
      require("overseer.task_list").list_tasks({ unique = true, status = "RUNNING", recent_first = true })
  end,
  static = {
    symbols = {
      ["CANCELED"] = " ",
      ["FAILURE"] = "󰅚 ",
      ["SUCCESS"] = "󰄴 ",
      ["RUNNING"] = "󰑮 ",
    },
  },

  overseer_running(),
  overseer_status("RUNNING"),
  overseer_status("SUCCESS"),
  overseer_status("FAILURE"),
  overseer_status("CANCELED"),
}

local statusline = {
  hl = { bg = "background" },
  {
    space,
    branch_name,
    left_padding,
    align,
    overseer,
    space,
    work_dir,
    space,
  },
}

local winbar = {
  fallthrough = false,
  hl = function()
    if conditions.is_active() then
      return { bg = "background" }
    else
      return { bg = "background_nc" }
    end
  end,
  {
    condition = function()
      return conditions.buffer_matches({
        filetype = { "fugitiveblame" },
      })
    end,
  },
  {
    condition = function()
      return not conditions.is_active()
    end,
    left_padding,
    space,
    file_name_block,
    align,
  },
  {
    condition = conditions.is_active,
    left_padding,
    space,
    file_name_block,
    git_status,
    align,
    diagnostics,
    space,
    ruler,
    space,
  },
}

local statuscolumn = {
  condition = function()
    return not conditions.buffer_matches({
      filetype = excluded_filetypes,
      buftype = excluded_buftypes,
    })
  end,

  { provider = " " },
  { provider = "%=%4{v:virtnum ? '' : &nu ? (&rnu && v:relnum ? v:relnum : v:lnum) . ' ' : ''}" },
  { provider = "%s " },
}

require("heirline").setup({
  statusline = statusline,
  winbar = winbar,
  statuscolumn = statuscolumn,
  opts = {
    colors = setup_colors,
    disable_winbar_cb = function(args)
      return conditions.buffer_matches({
        buftype = excluded_buftypes,
        filetype = excluded_filetypes,
      }, args.buf)
    end,
  },
})
vim.api.nvim_create_augroup("Heirline", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    utils.on_colorscheme(setup_colors)
  end,
  group = "Heirline",
})
