local g = vim.g
local api = vim.api
local lsp = require("plugin/lsp")
local colors = require("plugin/colors/utils")
local u = require("util")
local t_builtin = require("telescope.builtin")
local t_themes = require("telescope.themes")
local settings = require("settings")
local wk = require("which-key")

local silent = { silent = true }
local noremap = { noremap = true }
local noremapSilent = { noremap = true, silent = true }

local function grep_notes()
	return t_builtin.live_grep({
		prompt_title = "~ notes ~",
		cwd = "~/notes/tech",
	})
end

local function find_dotfiles()
	return t_builtin.find_files(t_themes.get_dropdown({
		find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
		cwd = "~/.dotfiles",
		prompt_title = "~ dotfiles ~",
		previewer = false,
	}))
end

g.mapleader = " "

u.remap("n", " ", "", noremap)
u.remap("x", " ", "", noremap)

-- CR after search to turn off highlight
u.remap("n", "<CR>", ":noh<CR><CR>", noremap)

u.remap("n", "j", "gj", noremap)
u.remap("n", "k", "gk", noremap)

u.remap("n", "Q", ":q<CR>", noremap)
u.remap("n", "W", ":w<CR>", noremap)

-- H/L to go to beginning/end of the line
u.remap("n", "H", "^", noremap)
u.remap("n", "L", "$", noremap)
u.remap("x", "H", "^", noremap)
u.remap("x", "L", "$", noremap)

-- just kidding
u.remap("i", "jk", "<ESC>", {})
u.remap("t", "jk", "<ESC>", {})

-- keep visual selection when indenting
u.remap("v", "<", "<gv", noremap)
u.remap("v", ">", ">gv", noremap)

-- move lines in visual mode
u.remap("n", "<leader>z]", "<C>move .+1<CR>", silent) -- Alacritty: Option + j
u.remap("n", "<leader>z[", "<C>move .-2<CR>", silent) -- Alacritty: Option + k
u.remap("x", "<leader>z]", ":move '>+1<CR>gv=gv", silent) -- Alacritty: Option + j
u.remap("x", "<leader>z[", ":move '<-2<CR>gv=gv", silent) -- Alacritty: Option + k

-- delete in v mode without loosing current yank
u.remap("v", "<leader>p", '"_dP', noremap)
u.remap("v", "y", "ygv<ESC>", noremap)

-- -- shoutout
-- u.remap("n", "<leader>so", ":luafile %<CR>", noremap)

-- tmux
u.remap("n", "<C-h>", ":TmuxNavigateLeft<CR>", noremapSilent)
u.remap("n", "<C-j>", ":TmuxNavigateDown<CR>", noremapSilent)
u.remap("n", "<C-k>", ":TmuxNavigateUp<CR>", noremapSilent)
u.remap("n", "<C-l>", ":TmuxNavigateRight<CR>", noremapSilent)

-- nvim tree
u.remap("n", "<C-n>", ":NvimTreeToggle<CR>", noremap)
u.remap("n", "<C-b>", ":NvimTreeFindFileToggle<CR>", noremap)

-- p <leader>o & <leader>O to newline without insert mode
u.remap("n", "<leader>o", ':<C-u>call append(line("."), repeat([""], v:count1))<CR>', noremapSilent)
u.remap("n", "<leader>O", ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>', noremapSilent)

-- quickfix
u.remap("n", "<leader>qc", ":cclose<CR>", noremap)
u.remap("n", "<leader>qn", ":cnext<CR>", noremap)
u.remap("n", "<leader>qo", ":copen<CR>", noremap)
u.remap("n", "<leader>qp", ":cprev<CR>", noremap)
u.remap("n", "<leader>qa", ":cc<CR>", noremap)

-- locationlist
u.remap("n", "<leader>lc", ":lclose<CR>", noremap)
u.remap("n", "<leader>ln", ":lnext<CR>", noremap)
u.remap("n", "<leader>lo", ":lopen<CR>", noremap)
u.remap("n", "<leader>lp", ":lprev<CR>", noremap)
u.remap("n", "<leader>la", ":ll<CR>", noremap)

-- git
wk.register({
	["<leader>g"] = {
		name = "git",
		["s"] = { ":Git<CR>", "Status", noremap = true },
		["c"] = { ":Git commit<CR>", "Commit", noremap = true },
		["u"] = { ":Git pull<CR>", "Pull", noremap = true },
		["l"] = { ":Git log<CR>", "Log", noremap = true },
		["p"] = { ":Git push<CR>", "Push", noremap = true },
		["b"] = { ":Git blame<CR>", "Blame", noremap = true },
		["h"] = { ":Gclog<CR>", "File history", noremap = true },

		["a"] = { ":Gitsigns stage_hunk<CR>", "Stage hunk", mode = { "v", "n" }, noremap = true },
		["A"] = { ":Gitsigns stage_buffer<CR>", "Stage buffer", noremap = true },
		["d"] = { ":Gitsigns undo_stage_hunk<CR>", "Undo stage hunk", mode = { "v", "n" }, noremap = true },
		["r"] = { ":Gitsigns reset_hunk<CR>", "Reset hunk", mode = { "v", "n" }, noremap = true },
		["g"] = { ":Gitsigns preview_hunk<CR>", "Preview hunk", noremap = true },
		["n"] = { ":Gitsigns next_hunk<CR>", "Next hunk", noremap = true },
		["N"] = { ":Gitsigns prev_hunk<CR>", "Previous hunk", noremap = true },

		["o"] = { ":DiffviewOpen origin/master...HEAD<CR>", "Diffview master", noremap = true },
	},
})

-- telescope
u.remap("n", "<leader><leader>p", t_builtin.find_files, noremap)
u.remap("n", "<C-p>", t_builtin.live_grep, noremap)
u.remap("n", "<leader>fn", grep_notes, noremap)
u.remap("n", "<leader>fd", find_dotfiles, noremap)
u.remap("n", "<leader>fh", t_builtin.help_tags, noremap)
u.remap("n", "<leader>fm", t_builtin.keymaps, noremap)
u.remap("n", "<leader>fc", t_builtin.commands, noremap)
u.remap("n", "<leader>fi", t_builtin.highlights, noremap)
u.remap("n", "<leader>fb", t_builtin.buffers, noremap)
u.remap("n", "<leader>fs", t_builtin.current_buffer_fuzzy_find, noremap)
u.remap("n", "<leader>fg", t_builtin.git_branches, noremap)
u.remap("n", "<leader>fx", t_builtin.diagnostics, noremap)
u.remap("n", "<leader>fr", t_builtin.resume, noremap)

-- lsp/diagnostics/trouble
u.remap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", noremapSilent)
u.remap("n", "gD", "<cmd>Telescope lsp_declarations<CR>", noremapSilent)
u.remap("n", "gr", "<cmd>Trouble lsp_references<CR>", noremapSilent)
u.remap("n", "K", vim.lsp.buf.hover, noremapSilent)
u.remap("v", "<C-f>", lsp.format, noremapSilent)
u.remap("n", "<C-f>", lsp.format, noremapSilent)
u.remap("n", "<leader>cr", vim.lsp.buf.rename, noremapSilent)
u.remap("n", "<leader>ca", vim.lsp.buf.code_action, noremapSilent)
u.remap("n", "<leader>cs", vim.diagnostic.open_float, noremapSilent)
u.remap("n", "<leader>cn", vim.diagnostic.goto_next, noremapSilent)
u.remap("n", "<leader>cN", vim.diagnostic.goto_prev, noremapSilent)
u.remap("n", "<leader>cd", vim.diagnostic.get, noremapSilent)
u.remap("n", "<leader>k", vim.lsp.buf.signature_help, noremapSilent)
u.remap("n", "<leader>d", "<cmd>Glance references<CR>", noremapSilent)
u.remap("n", "<leader>xx", "<cmd>Trouble<CR>", noremapSilent)
u.remap("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<CR>", noremapSilent)
u.remap("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<CR>", noremapSilent)
u.remap("n", "<leader>xl", "<cmd>Trouble loclist<CR>", noremapSilent)
u.remap("n", "<leader>xq", "<cmd>Trouble quickfix<CR>", noremapSilent)
u.remap("n", "<leader>qN", "<cmd>lua require('trouble').previous({skip_groups = true, jump = true})<CR>", noremapSilent)
u.remap("n", "<leader>qn", "<cmd>lua require('trouble').next({skip_groups = true, jump = true})<CR>", noremapSilent)

-- search
u.remap("n", "n", [[<Cmd>execute('normal! ' . v:count1 . 'nzz')<CR><Cmd>lua require('hlslens').start()<CR>]], silent)
u.remap("n", "N", [[<Cmd>execute('normal! ' . v:count1 . 'Nzz')<CR><Cmd>lua require('hlslens').start()<CR>]], silent)
u.remap("n", "*", [[*zz<Cmd>lua require('hlslens').start()<CR>]], silent)
u.remap("n", "#", [[#zz<Cmd>lua require('hlslens').start()<CR>]], silent)
u.remap("n", "g*", [[g*zz<Cmd>lua require('hlslens').start()<CR>]], silent)
u.remap("n", "g#", [[g#zz<Cmd>lua require('hlslens').start()<CR>]], silent)
u.remap("n", "<C-d>", "<C-d>zz", noremapSilent)
u.remap("n", "<C-u>", "<C-u>zz", noremapSilent)

-- substitute
u.remap("n", "s", "<cmd>lua require('substitute').operator()<CR>", noremap)
u.remap("n", "ss", "<cmd>lua require('substitute').line()<CR>", noremap)
u.remap("n", "S", "<cmd>lua require('substitute').eol()<CR>", noremap)
u.remap("x", "s", "<cmd>lua require('substitute').visual()<CR>", noremap)

-- cybu
u.remap("n", "<leader>zz", ":CybuLastusedPrev<CR>") -- Alacritty: Control + [
u.remap("n", "<leader>zx", ":CybuLastusedNext<CR>") -- Alacritty: Control + ]

wk.register({
	["<leader>s"] = {
		name = "settings",
		f = { settings.toggle_format_on_save, "Toggle on save formatting" },
		p = { settings.toggle_format_prettier, "Toggle prettier formatting" },
		e = { settings.toggle_format_eslint, "Toggle eslint formatting" },
		u = { settings.toggle_diagnostic_underline, "Toggle diagnostic underline" },
		v = { settings.toggle_diagnostic_virtual, "Toggle diagnostic virtual" },
	},
})

api.nvim_create_user_command("WQ", "wq", {})
api.nvim_create_user_command("Wq", "wq", {})
api.nvim_create_user_command("W", "w", {})
api.nvim_create_user_command("Qa", "qa", {})
api.nvim_create_user_command("Q", "q", {})
api.nvim_create_user_command("Lw", "w", {})

vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
vim.keymap.set("n", "g<C-a>", require("dial.map").inc_gnormal(), { noremap = true })
vim.keymap.set("n", "g<C-x>", require("dial.map").dec_gnormal(), { noremap = true })
vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })
vim.keymap.set("v", "g<C-a>", require("dial.map").inc_gvisual(), { noremap = true })
vim.keymap.set("v", "g<C-x>", require("dial.map").dec_gvisual(), { noremap = true })

wk.register({
	["<leader>t"] = {
		name = "theme",
		["1"] = {
			function()
				colors.switch_colorscheme("mellifluous")
			end,
			"mellifluous",
		},
		["2"] = {
			function()
				colors.switch_colorscheme("duskfox")
			end,
			"duskfox",
		},
		["3"] = {
			function()
				colors.switch_colorscheme("base2tone_drawbridge_dark")
			end,
			"drawbridge",
		},
		["4"] = {
			function()
				colors.switch_colorscheme("no-clown-fiesta")
			end,
			"no-clown-fiesta",
		},
	},
})
