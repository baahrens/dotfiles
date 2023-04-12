vim.fn.setenv("MACOSX_DEPLOYMENT_TARGET", "10.15")

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

local function get_plugin_config(name)
	return function()
		require("plugin/" .. name)
	end
end

local plugins = {
	-- =================== git ===================
	{
		"tpope/vim-fugitive",
		cmd = "Git",
	},

	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = get_plugin_config("gitsigns"),
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"sindrets/diffview.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		cmd = { "DiffviewOpen" },
		config = get_plugin_config("diffview"),
	},

	-- =================== UI ===================
	{
		"aktersnurra/no-clown-fiesta.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("no-clown-fiesta").setup({
				transparent = false,
				styles = {
					comments = {},
					keywords = {},
					functions = {},
					variables = {},
					type = { bold = true },
					lsp = { underline = true },
				},
			})
			require("colors")
		end,
	},
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nightfox").setup({
				options = {
					transparent = true,
				},
			})
		end,
	},

	{
		"stevearc/dressing.nvim",
		config = get_plugin_config("dressing"),
		event = "VeryLazy",
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = get_plugin_config("indent"),
	},

	{
		"levouh/tint.nvim",
		config = get_plugin_config("tint"),
		event = { "BufReadPost", "BufNewFile" },
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		config = get_plugin_config("noice"),
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},

	-- =================== treesitter ===================
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		config = get_plugin_config("treesitter"),
	},

	-- =================== various ===================
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = get_plugin_config("comment"),
	},

	{
		"tpope/vim-surround",
		event = "VeryLazy",
	},

	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
		},
		config = get_plugin_config("tmux"),
	},

	{
		"kyazdani42/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle" },
		config = get_plugin_config("nvim_tree"),
		dependencies = {
			"kyazdani42/nvim-web-devicons",
		},
	},

	{
		"rebelot/heirline.nvim",
		event = "VeryLazy",
		commit = "750a112",
		config = get_plugin_config("heirline"),
	},

	{
		"nvim-telescope/telescope.nvim",
		config = get_plugin_config("telescope"),
		dependencies = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
		},
	},

	{
		"folke/trouble.nvim",
		config = get_plugin_config("trouble"),
		cmd = { "Trouble" },
	},

	{
		"kevinhwang91/nvim-hlslens",
		event = "VeryLazy",
		config = get_plugin_config("hlslens"),
	},

	{
		"gbprod/substitute.nvim",
		event = "VeryLazy",
		config = get_plugin_config("substitute"),
	},

	{
		"ghillb/cybu.nvim",
		config = get_plugin_config("cybu"),
		cmd = { "CybuLastusedPrev", "CybuLastusedNext" },
		dependencies = {
			"kyazdani42/nvim-web-devicons",
			"nvim-lua/plenary.nvim",
		},
	},

	{
		"dnlhc/glance.nvim",
		cmd = { "Glance" },
		config = get_plugin_config("glance"),
	},
	{
		"folke/which-key.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = get_plugin_config("which-key"),
	},

	{
		"L3MON4D3/LuaSnip",
		config = get_plugin_config("luasnip"),
		event = "InsertEnter",
	},

	{
		"hrsh7th/nvim-cmp",
		config = get_plugin_config("cmp"),
		event = "InsertEnter",
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
			require("plugin/lsp")
			require("plugin/lsp/lua")
			require("plugin/lsp/typescript")
			require("plugin/lsp/css")
			require("plugin/lsp/prisma")
			require("plugin/lsp/rust")
			require("plugin/lsp/tailwind")
		end,
	},
	{
		event = "VeryLazy",
		"williamboman/mason-lspconfig.nvim",
		config = get_plugin_config("mason-lspconfig"),
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		config = get_plugin_config("mason"),
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
		config = get_plugin_config("null-ls"),
		lazy = false,
		dependencies = {
			"williamboman/mason.nvim",
		},
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = get_plugin_config("mason-null-ls"),
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
	},
}

local lazy_config = {
	defaults = {
		lazy = true,
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
