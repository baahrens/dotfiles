local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

vim.api.nvim_create_autocmd("User", {
  pattern = "HeirlineInitWinbar",
  callback = function(args)
    local buf = args.buf
    local buftype = vim.tbl_contains({ "prompt", "nofile", "help", "quickfix" }, vim.bo[buf].buftype)
    local filetype = vim.tbl_contains({ "gitcommit", "fugitive" }, vim.bo[buf].filetype)
    if buftype or filetype then
      vim.opt_local.winbar = nil
    end
  end,
})

local colors = {
  red = utils.get_highlight("DiagnosticError").fg,
  green = utils.get_highlight("String").fg,
  blue = utils.get_highlight("Function").fg,
  gray = utils.get_highlight("Normal").fg,
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
    return " " .. table.concat(names, " ") .. ""
  end,
  hl = { fg = colors.gray },
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

local branch_name = {
  condition = conditions.is_git_repo,

  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,

  hl = { fg = colors.diag.warn },

  {
    provider = function(self)
      return " " .. self.status_dict.head
    end,
    hl = { bold = true },
  },
}

local git = {
  condition = conditions.is_git_repo,

  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,

  hl = { fg = colors.gray },

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

-- local Recording = {
--   condition = require("noice").api.statusline.mode.has,
--   provider = require("noice").api.statusline.mode.get,
-- }

local lazy = {
  condition = require("lazy.status").has_updates,
  update = { "User", pattern = "LazyUpdate" },
  provider = function()
    return "  " .. require("lazy.status").updates() .. " "
  end,
  hl = { fg = "gray" },
}

local DefaultStatusline = {
  space,
  space,
  work_dir,
  separator,
  branch_name,
  -- separator,
  -- Recording,
  align,
  lazy,
  space,
  lsp_servers,
  space,
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
}

local StatusLines = {
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
  fallthrough = false,

  SpecialStatusline,
  InactiveStatusline,
  DefaultStatusline,
}

local WinBars = {
  fallthrough = false,
  {
    condition = function()
      return conditions.buffer_matches({
        buftype = { "nofile", "prompt", "help", "quickfix" },
        filetype = { "^git.*", "fugitive" },
      })
    end,
    init = function()
      vim.opt_local.winbar = nil
    end,
  },
  {
    condition = function()
      return not conditions.is_active()
    end,
    space,
    space,
    file_name_block,
    align,
  },
  {
    space,
    space,
    file_name_block,
    separator,
    git,
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
})
