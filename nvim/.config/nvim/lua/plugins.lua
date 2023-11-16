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
    cmd = { "DiffviewOpen" },
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
    priority = 1000,
    lazy = false,
  },
  {
    "ramojus/mellifluous.nvim",
    priority = 1000,
    lazy = false,
  },
  {
    "aktersnurra/no-clown-fiesta.nvim",
    priority = 1000,
    lazy = false,
  },
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    lazy = false,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
  },

  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
  },

  {
    "stevearc/dressing.nvim",
    config = load_plugin_conf("dressing"),
    event = "VeryLazy",
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    config = load_plugin_conf("indent"),
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
  },

  {
    "luukvbaal/statuscol.nvim",
    event = "VeryLazy",
    config = load_plugin_conf("statuscol"),
  },

  -- =================== treesitter ===================
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    config = load_plugin_conf("treesitter"),
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = "nvim-treesitter",
  },
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = "nvim-treesitter",
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
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = load_plugin_conf("comment"),
  },

  {
    "echasnovski/mini.surround",
    event = { "BufReadPost", "BufNewFile" },
    config = load_plugin_conf("surround"),
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
    event = "VeryLazy",
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

  { "nvim-telescope/telescope-fzy-native.nvim" },

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
    "ghillb/cybu.nvim",
    config = load_plugin_conf("cybu"),
    cmd = { "CybuLastusedPrev", "CybuLastusedNext" },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
    },
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
    event = { "BufReadPre", "BufNewFile" },
  },

  {
    "hrsh7th/nvim-cmp",
    config = load_plugin_conf("cmp"),
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
  },

  -- =================== lsp ===================

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      load_plugin_conf("lsp")
    end,
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
}

local lazy_config = {
  defaults = {
    lazy = true,
  },
  ui = {
    border = "rounded",
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
