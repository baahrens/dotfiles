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
    })
  end,
})
