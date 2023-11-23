local settings = require("settings")
local overseer = require("overseer")

overseer.setup({
  task_list = {
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
      ["<C-f>"] = "OpenFloat",
      ["<C-q>"] = "OpenQuickFix",
      ["p"] = "TogglePreview",
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
    ["open output in quickfix"] = false,
  },
  task_win = {
    win_opts = { winblend = settings.winblend, },
  },
  form = {
    win_opts = { winblend = settings.winblend, },
  },
  confirm = {
    win_opts = { winblend = settings.winblend, },
  },
})

overseer.register_template({
  name = "reinstall dependencies",
  builder = function()
    return {
      priority = 1,
      name = "reinstall dependencies",
      strategy = {
        "orchestrator",
        tasks = {
          { "shell", cmd = "rm -rf node_modules" },
          { "shell", cmd = "yarn install" }
        },
      },
    }
  end
})

overseer.register_template({
  name = "install dependencies",
  builder = function()
    return {
      priority = 1,
      name = "install dependencies",
      cmd = "yarn install",
    }
  end
})
