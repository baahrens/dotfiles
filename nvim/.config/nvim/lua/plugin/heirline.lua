local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local colors = {
  red = utils.get_highlight("DiagnosticError").fg,
  green = utils.get_highlight("String").fg,
  blue = utils.get_highlight("Function").fg,
  gray = utils.get_highlight("NonText").fg,
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

local mode = {
  init = function(self)
    self.mode = vim.fn.mode(1)
  end,
  static = {
    mode_names = {
      n = "N",
      no = "N?",
      nov = "N?",
      noV = "N?",
      ["no^V"] = "N?",
      niI = "Ni",
      niR = "Nr",
      niV = "Nv",
      nt = "Nt",
      v = "V",
      vs = "Vs",
      V = "V_",
      Vs = "Vs",
      ["^V"] = "^V",
      ["^Vs"] = "^V",
      s = "S",
      S = "S_",
      ["^S"] = "^S",
      i = "I",
      ic = "Ic",
      ix = "Ix",
      R = "R",
      Rc = "Rc",
      Rx = "Rx",
      Rv = "Rv",
      Rvc = "Rv",
      Rvx = "Rv",
      c = "C",
      cv = "Ex",
      r = "...",
      rm = "M",
      ["r?"] = "?",
      ["!"] = "!",
      t = "T",
    },
    mode_colors = {
      n = colors.red ,
      i = colors.green,
      v = colors.cyan,
      V =  colors.cyan,
      ["^V"] =  colors.cyan,
      c =  colors.orange,
      s =  colors.purple,
      S =  colors.purple,
      ["^S"] =  colors.purple,
      R =  colors.orange,
      r =  colors.orange,
      ["!"] =  colors.red,
      t =  colors.red,
    }
  },
  provider = function(self)
    return " %2("..self.mode_names[self.mode].."%)"
  end,
  hl = function(self)
    local mode = self.mode:sub(1, 1)
    return { fg = self.mode_colors[mode], style = "bold", }
  end,
}

local file_icon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self)
    return self.icon and (self.icon .. " ")
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end
}

local file_name = {
  provider = function(self)
    local filename = vim.fn.fnamemodify(self.filename, ":.")
    if filename == "" then
      return "[No Name]"
    end
    if not conditions.width_percent_below(#filename, 0.25) then
      filename = vim.fn.pathshorten(filename)
    end
    return filename
  end,
  hl = { fg = colors.blue },
}

local FileFlags = {
  {
    provider = function() if vim.bo.modified then return " [+] " end end,
    hl = { fg = colors.green }

  }, {
    provider = function() if (not vim.bo.modifiable) or vim.bo.readonly then return "" end end,
    hl = { fg = colors.orange }
  }
}

local file_name_modifier = {
  hl = function()
    if vim.bo.modified then
      return { fg = colors.cyan, style = 'bold', force = true }
    end
  end,
}

local file_name_block = utils.insert(
  {
    init = function(self)
      self.filename = vim.api.nvim_buf_get_name(0)
    end,
  },
  file_icon,
  utils.insert(file_name_modifier, file_name),
  unpack(FileFlags),
  { provider = '%<'}
)

local ruler = {
  -- %l = current line number
  -- %L = number of lines in the buffer
  -- %c = column number
  -- %P = percentage through file of displayed window
  provider = "%7(%l/%3L%):%2c %P",
  hl = { fg = colors.purple }
}

local lsp_servers = {
  condition = conditions.lsp_attached,

  provider  = function()
    local names = {}
    for _, server in ipairs(vim.lsp.buf_get_clients(0)) do
      table.insert(names, server.name)
    end
    return " [" .. table.concat(names, " ") .. "]"
  end,
  hl = { fg = colors.green, style = "bold" },
}

local diagnostics = {
  condition = conditions.has_diagnostics,

  static = {
    hint_icon = "",
    info_icon = "",
    warn_icon = "",
    error_icon = "",
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

local git = {
  condition = conditions.is_git_repo,

  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,

  hl = { fg = colors.orange },

  {
    provider = function(self)
      return " " .. self.status_dict.head
    end,
    hl = { style = 'bold' }
  },
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and (" +" .. count)
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
    local trail = cwd:sub(-1) == '/' and '' or "/"
    return " " .. cwd  .. trail
  end,
  hl = { fg = colors.blue, style = "bold" },
}

local align = { provider = "%=" }
local space = { provider = "   " }

local DefaultStatusline = {
  space,
  mode, space,
  file_name_block, space,
  git, space,
  diagnostics, align,
  lsp_servers, space,
  work_dir, space,
  ruler,
  space
}

local SpecialStatusline = {
  condition = function()
    return conditions.buffer_matches({
      buftype = { "nofile", "prompt", "help", "quickfix" },
      filetype = { "^git.*", "fugitive" },
    })
  end,
}

local InactiveStatusline = {
  condition = function()
    return not conditions.is_active()
  end,

  space,
  file_name_block, align,
}

local StatusLines = {
  hl = function()
    if conditions.is_active() then
      return {
        fg = utils.get_highlight("StatusLine").fg,
        bg = utils.get_highlight("StatusLine").bg
      }
    else
      return {
        fg = utils.get_highlight("StatusLineNC").fg,
        bg = utils.get_highlight("StatusLineNC").bg
      }
    end
  end,
  init = utils.pick_child_on_condition,

  SpecialStatusline, InactiveStatusline, DefaultStatusline,
}

require("heirline").setup(StatusLines)
