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

-- =================== git ===================
  use { 'tpope/vim-fugitive' }

  use {
    'lewis6991/gitsigns.nvim',
    config = function() require'plugin/gitsigns' end,
    requires = {
      { 'nvim-lua/plenary.nvim' }
    }
  }

-- =================== UI ===================
  use {
    'EdenEast/nightfox.nvim' ,
    config = function()
      require('nightfox').setup({
        options = {
          transparent = true
        }
      })
    end
  }

  use {
    'stevearc/dressing.nvim',
    config = function() require'plugin/dressing' end
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function() require'plugin/indent' end
  }

  use {
    "levouh/tint.nvim",
    config = function()
      require'plugin/tint'
    end
  }

-- =================== treesitter ===================
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function() require'plugin/treesitter' end
  }

  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = "nvim-treesitter",
    disable = true
  }

  use {
    'nvim-treesitter/playground',
    after = "nvim-treesitter",
    disable = true
  }
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
    config = function() require'plugin/nvim_tree' end,
    requires = {
      { 'kyazdani42/nvim-web-devicons', config = function() require'plugin/devicons' end }
    }
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
      'nvim-telescope/telescope-fzf-native.nvim',
    }
  }

  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
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
    config = function() require'plugin/substitute' end
  })

  use {
    "ghillb/cybu.nvim",
    branch = "main",
    config = function()
      require'plugin/cybu'
    end,
    requires = {
      { 'kyazdani42/nvim-web-devicons', config = function() require'plugin/devicons' end },
      "nvim-lua/plenary.nvim"
    }
  }

  -- =================== lsp ===================

  use {
    'L3MON4D3/LuaSnip',
    config = function() require'plugin/luasnip' end
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
      require'plugin/lsp/typescript'
      require'plugin/lsp/css'
      require'plugin/lsp/prisma'
      require'plugin/lsp/tailwind'
    end
  }

  use {
    'simrat39/rust-tools.nvim',
    config = function() require'plugin/rust-tools' end
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function() require'plugin/null-ls' end
  }
end, config = packer_config })
