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
    "atelierbram/Base2Tone-nvim",
    priority = theme_name == "base2tone_drawbridge_dark" and 1000 or 1,
  },

  {
    "mcchrish/zenbones.nvim",
    priority = theme_name == "zenwritten" or theme_name == "tokyobones" and 1000 or 1,
    dependencies = "rktjmp/lush.nvim"
  },

  {
    "ramojus/mellifluous.nvim",
    priority = theme_name == "mellifluous" and 1000 or 1,
  },

  {
    "aktersnurra/no-clown-fiesta.nvim",
    priority = theme_name == "no-clown-fiesta" and 1000 or 1,
  },

  {
    "EdenEast/nightfox.nvim",
    priority = theme_name == "nightfox" or theme_name == "nordfox" and 1000 or 1,
  },

  {
    "folke/tokyonight.nvim",
    priority = theme_name == "tokyonight" and 1000 or 1,
  },

  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = theme_name == "rose-pine" and 1000 or 1,
  },

  {
    "stevearc/dressing.nvim",
    config = load_plugin_conf("dressing"),
    lazy = false,
    event = "VeryLazy",
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    config = load_plugin_conf("indent"),
  },

  {
    'stevearc/overseer.nvim',
    cmd = { "OverseerRun", "OverseerToggle" },
    config = load_plugin_conf("overseer"),
  },

  {
    "levouh/tint.nvim",
    config = load_plugin_conf("tint"),
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = load_plugin_conf("noice"),
    dependencies = "MunifTanjim/nui.nvim",
    commit = "d9328ef903168b6f52385a751eb384ae7e906c6f"
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
    ft = { "html", "javascriptreact", "typescriptreact", "tsx", "jsx" }
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    config = load_plugin_conf("context"),
    dependencies = "nvim-treesitter",
  },

  -- =================== various ===================
  {
    "Wansmer/treesj",
    keys = { "<space>m" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesj").setup({
        use_default_keymaps = false,
      })
    end,
  },

  {
    "uga-rosa/ccc.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = load_plugin_conf("ccc"),
  },

  {
    "tpope/vim-surround",
    lazy = false,
    keys = { "c", "d", "y" }
  },

  {
    "echasnovski/mini.jump",
    event = "InsertEnter",
    config = load_plugin_conf("jump"),
  },

  {
    "echasnovski/mini.ai",
    event = "InsertEnter",
    config = load_plugin_conf("ai"),
  },

  {
    'mrjones2014/smart-splits.nvim',
    config = load_plugin_conf("smart-splits"),
    lazy = false
  },

  {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = load_plugin_conf("oil"),
    cmd = { "Oil" },
  },

  {
    "rebelot/heirline.nvim",
    event = "VeryLazy",
    config = load_plugin_conf("heirline"),
  },

  {
    "nvim-telescope/telescope.nvim",
    config = load_plugin_conf("telescope"),
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {
    "danielfalk/smart-open.nvim",
    lazy = false,
    dependencies = {
      "kkharji/sqlite.lua",
      'nvim-telescope/telescope-fzf-native.nvim'
    },
  },

  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    config = load_plugin_conf("bqf")
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
    "hrsh7th/nvim-cmp",
    config = load_plugin_conf("cmp"),
    event = { "InsertEnter" },
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lua",
    },
  },

  -- =================== lsp ===================

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = load_plugin_conf("lsp")
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = load_plugin_conf("mason-lspconfig"),
    cmd = "LspInstall"
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = load_plugin_conf("mason"),
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    config = load_plugin_conf("null-ls"),
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = load_plugin_conf("mason-null-ls"),
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
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
    branch = "canary",
    lazy = false,
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    config = load_plugin_conf("copilot-chat"),
  },
  {
    "goolord/alpha-nvim",
    lazy = false,
    config = load_plugin_conf("alpha")
  },
}

local lazy_config = {
  defaults = {
    lazy = true,
  },
  ui = {
    border = settings.border
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
