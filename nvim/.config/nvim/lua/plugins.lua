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

-- =================== git ===================
  use {
    'tpope/vim-fugitive',
    cmd = 'Git'
  }

  use {
    'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function() require'plugin/gitdiff' end
  }

  use {
    'lewis6991/gitsigns.nvim',
    event = { 'BufRead','BufNewFile' },
    config = function() require'plugin/gitsigns' end,
    requires = {
      { 'nvim-lua/plenary.nvim' }
    }
  }

-- =================== colorschemes ===================
  use { 'marko-cerovac/material.nvim',        disable = true }

  use { 'savq/melange',                       disable = true }

  use { 'rose-pine/neovim', as = 'rose-pine', disable = true }

  use { 'folke/tokyonight.nvim',              disable = true }

  use { 'tyrannicaltoucan/vim-deep-space',    disable = true }

  use { 'shaunsingh/nord.nvim' }

-- =================== treesitter ===================
  use({
    {
      'nvim-treesitter/nvim-treesitter',
      branch = '0.5-compat',
      run = ':TSUpdate',
      config = function() require'plugin/treesitter' end
    },

    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      disable = true,
      event = "CursorHold",
      branch = '0.5-compat'
    },

    { 'nvim-treesitter/playground', disable = true },

    {
      'windwp/nvim-ts-autotag',
      ft = { "javascriptreact", "typescriptreact", "html", "xml" }
    },
  })

-- =================== filetypes ===================
  use {
    'maxmellon/vim-jsx-pretty',
    ft = { 'typescriptreact', 'javascriptreact' }
  }

  use {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    run = 'cd app && yarn install'
  }

-- =================== various ===================
  use {
    'terrortylor/nvim-comment',
    config = function() require'plugin/nvim_comment' end
  }

  use 'tpope/vim-surround'

  use {
    'christoomey/vim-tmux-navigator',
    config = function() require'plugin/tmux' end
  }

  use {
    'norcalli/nvim-colorizer.lua',
    ft = { 'css', 'javascriptreact', 'javascript', 'typescriptreact', 'vim', 'lua' },
    config = function() require'plugin/colorizer' end
  }

  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    config = function() require'plugin/galaxyline' end,
    requires = {
      { 'kyazdani42/nvim-web-devicons', config = function() require'plugin/devicons' end }
    }
  }

  use {
    'kyazdani42/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeOpen' },
    config = function() require'plugin/nvim_tree' end,
    requires = {
      { 'kyazdani42/nvim-web-devicons', config = function() require'plugin/devicons' end }
    }
  }

  use {
    'nvim-telescope/telescope.nvim',
    config = function() require'plugin/telescope' end,
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzy-native.nvim',
    }
  }

  use {
    'kevinhwang91/nvim-bqf'
  }

  use {
    'folke/trouble.nvim',
    config = function() require'plugin/trouble' end
  }

  -- =================== lsp ===================

  use {
    'L3MON4D3/LuaSnip',
    event = 'InsertEnter',
    wants = 'friendly-snippets',
    after = "nvim-cmp",
    config = function() require'plugin/luasnip' end
  }

  use {
    'rafamadriz/friendly-snippets'
  }

  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-nvim-lua' }
  use { 'David-Kunz/cmp-npm' }

  use {
    'hrsh7th/nvim-cmp',
    config = function() require'plugin/cmp' end
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

  use { 'ray-x/lsp_signature.nvim' }
end, config = packer_config })
