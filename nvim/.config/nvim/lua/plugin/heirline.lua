local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local settings = require("settings")

local colors = {
  red = utils.get_highlight("DiagnosticError").fg,
  green = utils.get_highlight("String").fg,
  blue = utils.get_highlight("Function").fg,
  gray = utils.get_highlight("Keyword").fg,
  inactive = utils.get_highlight("LineNr").fg,
  orange = utils.get_highlight("DiagnosticWarn").fg,
  purple = utils.get_highlight("Statement").fg,
  cyan = utils.get_highlight("Special").fg,
  diag = {
    warn = utils.get_highlight("DiagnosticWarn").fg,
    error = utils.get_highlight("DiagnosticError").fg,
    hint = utils.get_highlight("DiagnosticHint").fg,
    info = utils.get_highlight("DiagnosticInfo").fg,
  },
  git = {
    del = utils.get_highlight("diffRemoved").fg,
    add = utils.get_highlight("diffAdded").fg,
    change = utils.get_highlight("diffChanged").fg,
  },
}

local align = { provider = "%=" }
local space = { provider = "   " }
local separator = { provider = "  │  ", hl = { fg = colors.inactive } }

local mode = {
  init = function(self)
    self.mode = vim.fn.mode(1)
  end,
  static = {
    mode_names = {
      n = "Normal",
      no = "N?",
      nov = "N?",
      noV = "N?",
      ["no\22"] = "N?",
      niI = "Ni",
      niR = "Nr",
      niV = "Nv",
      nt = "Nt",
      v = "Visual",
      vs = "Vs",
      V = "VLine",
      Vs = "Vs",
      ["\22"] = "VBlock",
      ["\22s"] = "VBlock",
      s = "S",
      S = "S_",
      ["\19"] = "^S",
      i = "Insert",
      ic = "Ic",
      ix = "Ix",
      R = "R",
      Rc = "Rc",
      Rx = "Rx",
      Rv = "Rv",
      Rvc = "Rv",
      Rvx = "Rv",
      c = "Command",
      cv = "Ex",
      r = "...",
      rm = "M",
      ["r?"] = "?",
      ["!"] = "!",
      t = "T",
    },
    mode_colors = {
      n = colors.diag.info,
      i = colors.diag.warn,
      v = colors.diag.hint,
      V = colors.diag.hint,
      ["\22"] = colors.diag.hint,
      c = "orange",
      s = "purple",
      S = "purple",
      ["\19"] = "purple",
      R = "orange",
      r = "orange",
      ["!"] = "red",
      t = "red",
    }
  },
  provider = function(self)
    return self.mode_names[self.mode]
  end,
  hl = function(self)
    local mode = self.mode:sub(1, 1)
    return { fg = self.mode_colors[mode], bold = true, }
  end,
  update = {
    "ModeChanged",
    pattern = "*:*",
    callback = vim.schedule_wrap(function()
      vim.cmd("redrawstatus")
    end),
  },
}

local file_icon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color =
        require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self)
    return self.icon and (self.icon .. " ")
  end,
  hl = function(self)
    return { fg = self.icon_color }
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
  hl = function()
    if conditions.is_active() then
      return { fg = colors.diag.warn }
    else
      return { fg = colors.inactive }
    end
  end,
}

local FileFlags = {
  {
    provider = function()
      if vim.bo.modified then
        return " [+] "
      end
    end,
    hl = { fg = colors.green },
  },
  {
    provider = function()
      if (not vim.bo.modifiable) or vim.bo.readonly then
        return ""
      end
    end,
    hl = { fg = colors.orange },
  },
}

local file_name_modifier = {
  hl = function()
    if vim.bo.modified then
      return { fg = colors.cyan, bold = true, force = true }
    end
  end,
}

local file_name_block = utils.insert({
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
}, file_icon, utils.insert(file_name_modifier, file_name), unpack(FileFlags), { provider = "%<" })

local ruler = {
  -- %l = current line number
  -- %L = number of lines in the buffer
  -- %c = column number
  -- %P = percentage through file of displayed window
  provider = "%l/%3L%: %2c %P",
  hl = { fg = colors.purple },
}

local lsp_servers = {
  condition = conditions.lsp_attached,

  provider = function()
    local names = {}
    for _, server in ipairs(vim.lsp.buf_get_clients(0)) do
      table.insert(names, server.name)
    end
    return " " .. table.concat(names, " - ") .. ""
  end,
  hl = { fg = colors.gray },
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
    hl = { fg = colors.diag.error },
  },
  {
    provider = function(self)
      return self.warnings > 0 and (self.warn_icon .. " " .. self.warnings .. " ")
    end,
    hl = { fg = colors.diag.warn },
  },
  {
    provider = function(self)
      return self.info > 0 and (self.info_icon .. " " .. self.info .. " ")
    end,
    hl = { fg = colors.diag.info },
  },
  {
    provider = function(self)
      return self.hints > 0 and (self.hint_icon .. " " .. self.hints)
    end,
    hl = { fg = colors.diag.hint },
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
    hl = { bold = true, fg = colors.diag.warn },
  },
}

local git_status = {
  condition = conditions.is_git_repo,

  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
  end,

  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and ("+" .. count)
    end,
    hl = { fg = colors.git.add },
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and (" -" .. count)
    end,
    hl = { fg = colors.git.del },
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and (" ~" .. count)
    end,
    hl = { fg = colors.git.change },
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
    return " " .. cwd .. trail
  end,
  hl = { fg = colors.gray },
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
      return string.format("[%s]  ", running_tasks)
    end,
    hl = function()
      return {
        fg = colors.diag.info
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
      local icon_color = status == "CANCELED" and colors.diag.warn
          or status == "RUNNING" and colors.diag.info
          or status == "SUCCESS" and colors.diag.hint
          or colors.diag.error
      return {
        fg = icon_color
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
    self.running_tasks = require("overseer.task_list").list_tasks({ unique = true, status = "RUNNING", recent_first = true })
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

local DefaultStatusline = {
  space,
  mode,
  space,
  work_dir,
  separator,
  branch_name,
  align,
  overseer,
  separator,
  lsp_servers,
}

local StatusLines = {
  fallthrough = false,
  hl = function()
    if conditions.is_active() then
      return {
        fg = utils.get_highlight("StatusLine").fg,
        bg = utils.get_highlight("StatusLine").bg,
      }
    else
      return {
        fg = utils.get_highlight("StatusLineNC").fg,
        bg = utils.get_highlight("StatusLineNC").bg,
      }
    end
  end,
  DefaultStatusline,
}

local WinBars = {
  fallthrough = false,
  {
    condition = function() return not conditions.is_active() end,
    space,
    space,
    file_name_block,
    align,
  },
  {
    condition = conditions.is_active,
    space,
    space,
    file_name_block,
    separator,
    git_status,
    align,
    diagnostics,
    separator,
    ruler,
    space,
  },
}

require("heirline").setup({
  statusline = StatusLines,
  winbar = WinBars,
  opts = {
    disable_winbar_cb = function(args)
      return conditions.buffer_matches({
        buftype = { "nofile", "prompt", "help", "quickfix", "terminal" },
        filetype = { "^git.*", "fugitive", "noice", "oil", "TelescopePrompt", "TelescopeResults", "OverseerForm", "OverseerList" },
      }, args.buf)
    end
  }
})
