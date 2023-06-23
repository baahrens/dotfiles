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
		"stevearc/dressing.nvim",
		config = load_plugin_conf("dressing"),
		event = "VeryLazy",
	},

	{
		"lukas-reineke/indent-blankline.nvim",
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
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
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

	-- =================== various ===================
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
		"tpope/vim-surround",
		event = { "BufReadPost", "BufNewFile" },
	},

	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		config = load_plugin_conf("pairs"),
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
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
		},
		config = load_plugin_conf("tmux"),
	},
	{
		"monaqa/dial.nvim",
		config = load_plugin_conf("dial"),
		lazy = false,
	},
	{
		"kyazdani42/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle" },
		config = load_plugin_conf("nvim_tree"),
		dependencies = {
			"kyazdani42/nvim-web-devicons",
		},
	},

	{
		"rebelot/heirline.nvim",
		event = "VeryLazy",
		commit = "750a112",
		config = load_plugin_conf("heirline"),
	},

	{
		"nvim-telescope/telescope.nvim",
		config = load_plugin_conf("telescope"),
		dependencies = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
		},
	},

	{ "nvim-telescope/telescope-fzy-native.nvim" },

	{
		"folke/trouble.nvim",
		config = load_plugin_conf("trouble"),
		cmd = { "Trouble" },
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
			"kyazdani42/nvim-web-devicons",
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
		event = "InsertEnter",
	},

	{
		"hrsh7th/nvim-cmp",
		config = load_plugin_conf("cmp"),
		event = "InsertEnter",
		commit = "1cad30fcffa282c0a9199c524c821eadc24bf939",
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
		config = load_plugin_conf("mason-lspconfig"),
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
		"yioneko/nvim-vtsls",
		event = { "BufReadPre", "BufNewFile" },
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
