vim.fn.setenv('MACOSX_DEPLOYMENT_TARGET', '10.15')

local packer_config = {
  display = {
    open_fn = require('packer.util').float,
    profile = {
      enable = false,
      threshold = 1,
    }
  }
}

return require('packer').startup({ function()
  use 'wbthomason/packer.nvim'
  use 'lewis6991/impatient.nvim'
  use 'nathom/filetype.nvim'

-- =================== git ===================
  use {
    'tpope/vim-fugitive',
    cmd = 'Git'
  }

  use {
    'lewis6991/gitsigns.nvim',
    event = { 'BufRead','BufNewFile' },
    config = function() require'plugin/gitsigns' end,
    requires = {
      { 'nvim-lua/plenary.nvim' }
    }
  }

-- =================== colors ===================
  use { 'marko-cerovac/material.nvim',        disable = true }

  use { 'savq/melange',                       disable = true }

  use { 'rose-pine/neovim', as = 'rose-pine', disable = true }

  use { 'folke/tokyonight.nvim',              disable = true }

  use { 'tyrannicaltoucan/vim-deep-space',    disable = true }

  use { 'shaunsingh/nord.nvim' }

  use {
    'norcalli/nvim-colorizer.lua',
    ft = {
      'css',
      'javascriptreact',
      'javascript',
      'typescriptreact',
      'vim',
      'lua'
    },
    config = function() require'plugin/colorizer' end
  }

-- =================== treesitter ===================
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function() require'plugin/treesitter' end
  }

  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = "CursorHold",
    after = "nvim-treesitter",
    disable = true
  }

  use {
    'nvim-treesitter/playground',
    after = "nvim-treesitter",
    disable = true
  }

  use {
    'windwp/nvim-ts-autotag',
    after = "nvim-treesitter"
  }
  --
-- =================== filetypes ===================
  use {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    run = 'cd app && yarn install'
  }

-- =================== various ===================
  use {
    'numToStr/Comment.nvim',
    config = function() require'plugin/comment' end
  }

  use 'tpope/vim-surround'

  use {
    'christoomey/vim-tmux-navigator',
    config = function() require'plugin/tmux' end
  }

  use {
    'kyazdani42/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeFindFile' },
    config = function() require'plugin/nvim_tree' end,
    requires = {
      { 'kyazdani42/nvim-web-devicons', config = function() require'plugin/devicons' end }
    }
  }
  use {
    "akinsho/toggleterm.nvim",
    config = function() require'plugin/toggleterm' end
  }

  use {
    'rebelot/heirline.nvim',
    config = function() require'plugin/heirline' end
  }

  use {
    'nvim-telescope/telescope.nvim',
    config = function() require'plugin/telescope' end,
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'natecraddock/telescope-zf-native.nvim'
    }
  }

  use {
    'kevinhwang91/nvim-bqf'
  }

  use {
    'ThePrimeagen/harpoon'
  }

  use {
    'folke/trouble.nvim',
    config = function() require'plugin/trouble' end
  }

  use {
    'kevinhwang91/nvim-hlslens',
    config = function() require'plugin/hlslens' end
  }

  use({
    "gbprod/substitute.nvim",
    config = function() require("plugin/substitute") end
  })

   use {
    'stevearc/dressing.nvim'
  }
  -- =================== lsp ===================

  use {
    'L3MON4D3/LuaSnip',
    event = 'InsertEnter',
    after = "nvim-cmp",
    config = function() require'plugin/luasnip' end,
    requires = {
      'rafamadriz/friendly-snippets',
    }
  }

  use {
    'hrsh7th/nvim-cmp',
    config = function() require'plugin/cmp' end,
    requires = {
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        "lukas-reineke/cmp-rg",
        'hrsh7th/cmp-cmdline',
        { 'hrsh7th/cmp-nvim-lua', ft = { 'lua' } }
      }

  }

  use {
    'neovim/nvim-lspconfig',
    config = function()
      require'plugin/lsp'
      require'plugin/lsp/lua'
      require'plugin/lsp/javascript'
      require'plugin/lsp/css'
    end
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function() require'plugin/null-ls' end
  }
end, config = packer_config })
