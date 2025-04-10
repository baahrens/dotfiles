local settings = require("settings")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local function load_plugin_conf(name)
  return function()
    local ok, conf = pcall(require, "plugin/" .. name)
    if not ok then
      print("Error loading " .. name .. ". Error: " .. conf)
    end
  end
end

local theme_name = vim.fn.getenv("THEME") or "duskfox"

local function theme_priority(...)
  local args = { ... }
  local priority = 1

  for _, v in ipairs(args) do
    if v == theme_name then
      priority = 1000
    end
  end

  return priority
end

local plugins = {
  -- =================== git ===================
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gclog" },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = load_plugin_conf("gitsigns"),
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    config = load_plugin_conf("diffview"),
  },

  -- =================== UI ===================
  {
    "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    config = load_plugin_conf("devicons"),
  },

  {
    "wnkz/monoglow.nvim",
    priority = theme_priority("monoglow"),
  },

  {
    "atelierbram/Base2Tone-nvim",
    priority = theme_priority("base2tone_drawbridge_dark"),
  },

  {
    "mcchrish/zenbones.nvim",
    priority = theme_priority("zenwritten", "tokyobones"),
    dependencies = "rktjmp/lush.nvim",
  },

  {
    "olivercederborg/poimandres.nvim",
    priority = theme_priority("poimandres"),
  },

  {
    "ramojus/mellifluous.nvim",
    priority = theme_priority("mellifluous"),
  },

  {
    "aktersnurra/no-clown-fiesta.nvim",
    priority = theme_priority("no-clown-fiesta"),
  },

  {
    "EdenEast/nightfox.nvim",
    priority = theme_priority("nightfox", "nordfox"),
  },

  {
    "folke/tokyonight.nvim",
    priority = theme_priority("tokyonight"),
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = theme_priority("rose-pine"),
  },

  {
    "nyoom-engineering/oxocarbon.nvim",
    priority = theme_priority("oxocarbon"),
  },

  {
    "slugbyte/lackluster.nvim",
    priority = theme_priority("lackluster"),
  },

  {
    "stevearc/overseer.nvim",
    cmd = { "OverseerRun", "OverseerToggle" },
    config = load_plugin_conf("overseer"),
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = load_plugin_conf("noice"),
    dependencies = "MunifTanjim/nui.nvim",
  },

  -- =================== treesitter ===================
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    config = load_plugin_conf("treesitter"),
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = "nvim-treesitter",
  },

  {
    "windwp/nvim-ts-autotag",
    dependencies = "nvim-treesitter",
    ft = { "html", "javascriptreact", "typescriptreact", "tsx", "jsx" },
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    config = load_plugin_conf("context"),
    dependencies = "nvim-treesitter",
  },

  -- =================== various ===================
  {
    "uga-rosa/ccc.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = load_plugin_conf("ccc"),
  },

  {
    "tpope/vim-surround",
    keys = { "c", "d", "y" },
  },

  {
    "echasnovski/mini.jump",
    event = "InsertEnter",
    config = load_plugin_conf("jump"),
  },

  {
    "echasnovski/mini.splitjoin",
    version = "*",
    config = function()
      require("mini.splitjoin").setup()
    end,
    lazy = false,
  },

  {
    "echasnovski/mini.ai",
    event = "InsertEnter",
    config = load_plugin_conf("ai"),
  },

  {
    "mrjones2014/smart-splits.nvim",
    config = load_plugin_conf("smart-splits"),
    lazy = false,
  },

  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = load_plugin_conf("oil"),
    cmd = { "Oil" },
  },

  {
    "rebelot/heirline.nvim",
    lazy = false,
    config = load_plugin_conf("heirline"),
  },

  {
    "stevearc/quicker.nvim",
    lazy = false,
    config = load_plugin_conf("quicker"),
  },

  {
    "kevinhwang91/nvim-hlslens",
    event = { "BufReadPre", "BufNewFile" },
    config = load_plugin_conf("hlslens"),
  },

  {
    "gbprod/substitute.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = load_plugin_conf("substitute"),
  },

  {
    "dnlhc/glance.nvim",
    cmd = { "Glance" },
    config = load_plugin_conf("glance"),
  },

  {
    "folke/which-key.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = load_plugin_conf("which-key"),
  },

  {
    "L3MON4D3/LuaSnip",
    config = load_plugin_conf("luasnip"),
    event = { "InsertEnter" },
  },

  {
    "saghen/blink.cmp",
    lazy = false,
    dependencies = {
      { "L3MON4D3/LuaSnip", version = "v2.*" },
      "fang2hou/blink-copilot",
    },
    version = "1.*",
    config = load_plugin_conf("blink"),
  },
  -- =================== lsp ===================

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = load_plugin_conf("lsp"),
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = load_plugin_conf("mason-lspconfig"),
    cmd = "LspInstall",
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = load_plugin_conf("mason"),
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    config = load_plugin_conf("tiny-inline-diagnostic"),
  },
  {
    "zbirenbaum/copilot.lua",
    lazy = false,
    enabled = vim.g.is_work_machine,
    config = load_plugin_conf("copilot"),
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    enabled = vim.g.is_work_machine,
    branch = "main",
    lazy = false,
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    config = load_plugin_conf("copilot-chat"),
  },
  {
    "stevearc/conform.nvim",
    lazy = false,
    config = load_plugin_conf("conform"),
  },
  {
    "mfussenegger/nvim-lint",
    lazy = false,
    config = load_plugin_conf("lint"),
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    config = load_plugin_conf("snacks"),
  },
}

local lazy_config = {
  defaults = {
    lazy = true,
  },
  ui = {
    backdrop = 0,
    border = settings.border,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tar",
        "tarPlugin",
        "zip",
        "zipPlugin",
        "getscript",
        "getscriptPlugin",
        "vimball",
        "vimballPlugin",
        "matchit",
        "2html_plugin",
        "logiPat",
        "rrhelper",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
      },
    },
  },
}

require("lazy").setup(plugins, lazy_config)
require("plugin/colors/theme").set_colorscheme(theme_name)
