local settings = require("settings")
local overseer = require("overseer")
local root_pattern = require("lspconfig.util").root_pattern

local has_package_json = root_pattern("package.json")
local has_package_lock_json = root_pattern("package-lock.json")
local has_yarn_lock = root_pattern("yarn.lock")

overseer.setup({
  dap = false,
  task_list = {
    direction = "right",
    width = 50,
    bindings = {
      ["?"] = "ShowHelp",
      ["g?"] = "ShowHelp",
      ["<CR>"] = "RunAction",
      ["<C-e>"] = "Edit",
      ["<C-r>"] = "<CMD>OverseerQuickAction restart<CR>",
      ["<C-d>"] = "<CMD>OverseerQuickAction dispose<CR>",
      ["o"] = "Open",
      ["<C-s>"] = "OpenSplit",
      ["<C-q>"] = "OpenQuickFix",
      ["K"] = "TogglePreview",
      ["L"] = "IncreaseDetail",
      ["H"] = "DecreaseDetail",
      ["["] = "DecreaseWidth",
      ["]"] = "IncreaseWidth",
      ["{"] = "PrevTask",
      ["}"] = "NextTask",
      ["q"] = "Close",
    }
  },
  actions = {
    watch = false,
    save = false,
    unwatch = false,
    open = false,
    ["open float"] = false,
    ["open vsplit"] = false,
    ["open tab"] = false,
  },
  help_win = {
    border = settings.border,
    win_opts = { winblend = settings.winblend, },
  },
  task_win = {
    border = settings.border,
    win_opts = { winblend = settings.winblend, },
  },
  form = {
    border = settings.border,
    win_opts = { winblend = settings.winblend, },
  },
  confirm = {
    border = settings.border,
    win_opts = { winblend = settings.winblend, },
  },
})

overseer.register_template({
  name = "Commands",
  generator = function(_, cb)
    cb({
      {
        name = "[Linux] Fix umlaute",
        builder = function()
          return {
            cmd = "setxkbmap -option compose:menu",
          }
        end,
        condition = {
          callback = function()
            return vim.g.is_work_machine
          end
        },
      },
      {
        name = "[Node] Add dependency",
        builder = function(params)
          local package_version = params.package_name .. "@" .. params.version
          return {
            name = "[Node] Add " .. package_version,
            cmd = { "yarn" },
            args = { "add", params.dev and "-D" or nil, package_version }
          }
        end,
        params = {
          package_name = { type = "string" },
          dev = { type = "boolean", default = false },
          version = { type = "string", default = "latest" }
        },
        condition = {
          callback = function(opts) return has_package_json(opts.dir) end,
        },
      },
      {
        name = "[Node] Reinstall dependencies",
        builder = function()
          return {
            name = "[Node] Reinstall dependencies",
            strategy = {
              "orchestrator",
              tasks = {
                { "shell", cmd = "rm -rf node_modules" },
                { "shell", cmd = "yarn install" }
              },
            },
          }
        end,
        condition = {
          callback = function(opts) return has_package_json(opts.dir) end,
        },
      },
      {
        name = "[Node] Install dependencies",
        builder = function()
          return {
            name = "[Node] Install dependencies",
            strategy = {
              "orchestrator",
              tasks = {
                { "shell", cmd = "yarn install" }
              },
            },
          }
        end,
        condition = {
          callback = function(opts) return has_package_json(opts.dir) and has_yarn_lock(opts.dir) end,
        },
      },
      {
        name = "[Node] Install dependencies",
        builder = function()
          return {
            name = "[Node] Install dependencies",
            strategy = {
              "orchestrator",
              tasks = {
                { "shell", cmd = "npm install" }
              },
            },
          }
        end,
        condition = {
          callback = function(opts)
            print(has_yarn_lock(opts.dir))
            return has_package_json(opts.dir) and has_package_lock_json(opts.dir)
          end,
        },
      }
    })
  end,
})
