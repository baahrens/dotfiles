local settings = require("settings")
local overseer = require("overseer")
local root_pattern = require("lspconfig.util").root_pattern

local has_package_json = root_pattern("package.json")
local has_build_zig_zon = root_pattern("build.zig.zon")
local has_package_lock_json = root_pattern("package-lock.json")
local has_yarn_lock = root_pattern("yarn.lock")

overseer.setup({
  dap = false,
  task_list = {
    direction = "right",
    width = 50,
    keymaps = {
          ["<C-r>"] = { "keymap.run_action", opts = { action = "restart" }, desc = "Do something cool" },
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
    win_opts = { winblend = settings.winblend },
  },
  task_win = {
    border = settings.border,
    win_opts = { winblend = settings.winblend },
  },
  form = {
    border = settings.border,
    win_opts = { winblend = settings.winblend },
  },
  confirm = {
    border = settings.border,
    win_opts = { winblend = settings.winblend },
  },
})

overseer.register_template({
  name = "Commands",
  generator = function(_, cb)
    cb({
      {
        name = "[Zig] build run",
        builder = function()
          return {
            cmd = "zig build run",
          }
        end,
        condition = {
          callback = function(opts)
            return has_build_zig_zon(opts.dir)
          end,
        },
      },
      {
        name = "[Node] Add dependency",
        builder = function(params)
          local package_version = params.package_name .. "@" .. params.version
          return {
            name = "[Node] Add " .. package_version,
            cmd = { "yarn" },
            args = { "add", params.dev and "-D" or nil, package_version },
          }
        end,
        params = {
          package_name = { type = "string" },
          dev = { type = "boolean", default = false },
          version = { type = "string", default = "latest" },
        },
        condition = {
          callback = function(opts)
            return has_package_json(opts.dir)
          end,
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
                { "shell", cmd = "yarn install" },
              },
            },
          }
        end,
        condition = {
          callback = function(opts)
            return has_package_json(opts.dir)
          end,
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
                { "shell", cmd = "yarn install" },
              },
            },
          }
        end,
        condition = {
          callback = function(opts)
            return has_package_json(opts.dir) and has_yarn_lock(opts.dir)
          end,
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
                { "shell", cmd = "npm install" },
              },
            },
          }
        end,
        condition = {
          callback = function(opts)
            return has_package_json(opts.dir) and has_package_lock_json(opts.dir)
          end,
        },
      },
    })
  end,
})
