local settings = require("settings")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
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
    "adibhanna/forest-night.nvim",
    priority = theme_priority("forest-night"),
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
    "hyperb1iss/silkcircuit-nvim",
    priority = theme_priority("silkcircuit"),
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
    'kyzabuilds/xeno.nvim',
    config = load_plugin_conf("xeno"),
    lazy = false,
  },

  {
    "stevearc/overseer.nvim",
    cmd = { "OverseerRun", "OverseerToggle", "OverseerShell" },
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
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
  },

  {
    "MeanderingProgrammer/treesitter-modules.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "css",
        "diff",
        "fish",
        "git_rebase",
        "gitcommit",
        "html",
        "javascript",
        "json",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "prisma",
        "query",
        "regex",
        "rust",
        "swift",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
        "zig",
      },
      fold = { enable = false },
      highlight = { enable = true },
      indent = { enable = false },
      incremental_selection = { enable = true },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
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
    version = "1.*",
    config = load_plugin_conf("luasnip"),
    event = { "InsertEnter" },
  },

  {
    "saghen/blink.cmp",
    lazy = false,
    dependencies = {
      { "L3MON4D3/LuaSnip", version = "1.*" },
    },
    version = "1.*",
    config = load_plugin_conf("blink"),
  },
  -- =================== lsp ===================

  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = load_plugin_conf("lsp"),
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = load_plugin_conf("mason-lspconfig"),
        dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
    cmd = "LspInstall",
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = load_plugin_conf("mason"),
  },
  {
    "j-hui/fidget.nvim",
    config = load_plugin_conf("fidget"),
    lazy = false,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    config = load_plugin_conf("tiny-inline-diagnostic"),
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
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
  },
  -- {
  --   "wojciech-kulik/xcodebuild.nvim",
  --   lazy = false,
  --   dependencies = {
  --     "folke/snacks.nvim",
  --     "MunifTanjim/nui.nvim",
  --   },
  --   config = function()
  --     require("xcodebuild").setup({})
  --   end,
  -- },
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
