vim.fn.setenv('MACOSX_DEPLOYMENT_TARGET', '10.15')

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

function get_plugin_config(name)
  return function()
    require('plugin/' .. name)
  end
end

local plugins = {
  {
    "williamboman/mason.nvim",
    config = get_plugin_config'mason'
  },

-- =================== git ===================
  { 'tpope/vim-fugitive' },

  {
    'lewis6991/gitsigns.nvim',
    config = get_plugin_config('gitsigns'),
    dependencies = {
      'nvim-lua/plenary.nvim'
    }
  },

-- =================== UI ===================
  {
    'EdenEast/nightfox.nvim' ,
    lazy = false,
    priority = 1000,
    config = function()
      require('nightfox').setup({
        options = {
          transparent = true
        }
      })
      require'colors'
    end
  },

  {
    'stevearc/dressing.nvim',
    config = get_plugin_config('dressing')
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    config = get_plugin_config('indent')
  },

  {
    "levouh/tint.nvim",
    config = get_plugin_config('tint')
  },
  {
    "folke/noice.nvim",
    config = get_plugin_config('noice'),
    dependencies = {
      "MunifTanjim/nui.nvim",
    }
  },

-- =================== treesitter ===================
  {
    'nvim-treesitter/nvim-treesitter',
    config = get_plugin_config('treesitter')
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = "nvim-treesitter",
    enabled = false
  },

  {
    'nvim-treesitter/playground',
    after = "nvim-treesitter",
    enabled = false
  },
-- =================== filetypes ===================
  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    build = 'cd app && yarn install'
  },

-- =================== various ===================
  {
    'numToStr/Comment.nvim',
    config = get_plugin_config('comment')
  },

  { 'tpope/vim-surround' },

  {
    'christoomey/vim-tmux-navigator',
    config = get_plugin_config('tmux')
  },

  {
    'kyazdani42/nvim-tree.lua',
    config = get_plugin_config('nvim_tree'),
    dependencies = {
      'kyazdani42/nvim-web-devicons'
    }
  },

  {
    'rebelot/heirline.nvim',
    config = get_plugin_config('heirline')
  },

  {
    'nvim-telescope/telescope.nvim',
    config = get_plugin_config('telescope'),
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
    }
  },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  },

  {
    'folke/trouble.nvim',
    config = get_plugin_config('trouble')
  },

  {
    'kevinhwang91/nvim-hlslens',
    config = get_plugin_config('hlslens')
  },

  {
    "gbprod/substitute.nvim",
    config = get_plugin_config('substitute')
  },
  {
    'Wansmer/treesj',
    dependencies = {
      'nvim-treesitter',
    },
    setup = true
  },

  {
    "ghillb/cybu.nvim",
    branch = "main",
    config = get_plugin_config('cybu'),
    dependencies = {
      'kyazdani42/nvim-web-devicons',
      "nvim-lua/plenary.nvim"
    }
  },

  -- =================== lsp ===================

  {
    "dnlhc/glance.nvim",
    config = get_plugin_config('glance')
  },

  {
    'L3MON4D3/LuaSnip',
    config = get_plugin_config('luasnip')
  },

  {
    'hrsh7th/nvim-cmp',
    config = get_plugin_config('cmp'),
    dependencies = {
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        "lukas-reineke/cmp-rg",
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lua'
      }
  },

  {
    'neovim/nvim-lspconfig',
    config = function()
      require'plugin/lsp'
      require'plugin/lsp/lua'
      require'plugin/lsp/typescript'
      require'plugin/lsp/css'
      require'plugin/lsp/prisma'
      require'plugin/lsp/tailwind'
    end
  },

  {
    'jose-elias-alvarez/null-ls.nvim',
    config = get_plugin_config('null-ls')
  }
}

local lazy_config = {
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
      }
    }
  }
}

require("lazy").setup(plugins, lazy_config)
