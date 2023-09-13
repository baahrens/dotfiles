local g = vim.g
local api = vim.api
local lsp = require("plugin/lsp")
local theme = require("plugin/colors/theme")
local u = require("util")
local t_builtin = require("telescope.builtin")
local t_themes = require("telescope.themes")
local settings = require("settings")
local wk = require("which-key")

local silent = { silent = true }
local noremap = { noremap = true }
local noremapSilent = { noremap = true, silent = true }

local function vim_cmd(cmd)
  return function()
    vim.cmd(cmd)
  end
end

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

u.remap("i", "<C-h>", "<C-O>h")
u.remap("i", "<C-l>", "<C-O>a")

-- just kidding
u.remap("i", "jk", "<ESC>", {})
u.remap("t", "jk", "<ESC>", {})

-- keep visual selection when indenting
u.remap("v", "<", "<gv", noremap)
u.remap("v", ">", ">gv", noremap)

-- move lines in visual mode
u.remap("n", "<leader>z]", "<C>move .+1<CR>", silent)     -- Alacritty: Option + j
u.remap("n", "<leader>z[", "<C>move .-2<CR>", silent)     -- Alacritty: Option + k
u.remap("x", "<leader>z]", ":move '>+1<CR>gv=gv", silent) -- Alacritty: Option + j
u.remap("x", "<leader>z[", ":move '<-2<CR>gv=gv", silent) -- Alacritty: Option + k

-- delete in v mode without loosing current yank
u.remap("v", "<leader>p", '"_dP', noremap)
u.remap("v", "y", "ygv<ESC>", noremap)

-- nvim tree
u.remap("n", "<C-n>", vim_cmd("NvimTreeToggle"), noremap)
u.remap("n", "<C-b>", vim_cmd("NvimTreeFindFileToggle"), noremap)

-- p <leader>o & <leader>O to newline without insert mode
u.remap("n", "<leader>o", ':<C-u>call append(line("."), repeat([""], v:count1))<CR>', noremapSilent)
u.remap("n", "<leader>O", ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>', noremapSilent)

-- quickfix
u.remap("n", "<leader>qc", vim_cmd("cclose"), noremap)
u.remap("n", "<leader>qn", vim_cmd("cnext"), noremap)
u.remap("n", "<leader>qo", vim_cmd("copen"), noremap)
u.remap("n", "<leader>qp", vim_cmd("cprev"), noremap)
u.remap("n", "<leader>qa", vim_cmd("cc"), noremap)

-- git
wk.register({
  ["<leader>g"] = {
    name = "git",
    ["s"] = { vim_cmd("Git"), "Status", noremap = true },
    ["c"] = { vim_cmd("Git commit"), "Commit", noremap = true },
    ["u"] = { vim_cmd("Git pull"), "Pull", noremap = true },
    ["l"] = { vim_cmd("Git log"), "Log", noremap = true },
    ["p"] = { vim_cmd("Git push"), "Push", noremap = true },
    ["b"] = { vim_cmd("Git blame"), "Blame", noremap = true },
    ["h"] = { vim_cmd("Gclog"), "File history", noremap = true },

    ["a"] = { vim_cmd("Gitsigns stage_hunk"), "Stage hunk", mode = { "v", "n" }, noremap = true },
    ["A"] = { vim_cmd("Gitsigns stage_buffer"), "Stage buffer", noremap = true },
    ["d"] = { vim_cmd("Gitsigns undo_stage_hunk"), "Undo stage hunk", mode = { "v", "n" }, noremap = true },
    ["r"] = { vim_cmd("Gitsigns reset_hunk"), "Reset hunk", mode = { "v", "n" }, noremap = true },
    ["g"] = { vim_cmd("Gitsigns preview_hunk"), "Preview hunk", noremap = true },
    ["n"] = { vim_cmd("Gitsigns next_hunk"), "Next hunk", noremap = true },
    ["N"] = { vim_cmd("Gitsigns prev_hunk"), "Previous hunk", noremap = true },

    ["o"] = { vim_cmd("DiffviewOpen origin/master...HEAD"), "Diffview master", noremap = true },
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
u.remap("n", "gd", vim_cmd("Telescope lsp_definitions"), noremapSilent)
u.remap("n", "gD", vim_cmd("Telescope lsp_declarations"), noremapSilent)
u.remap("n", "gr", vim_cmd("Trouble lsp_references"), noremapSilent)
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
u.remap("n", "<leader>d", vim_cmd("Glance references"), noremapSilent)
u.remap("n", "<leader>xx", vim_cmd("Trouble"), noremapSilent)
u.remap("n", "<leader>xw", vim_cmd("Trouble lsp_workspace_diagnostics"), noremapSilent)
u.remap("n", "<leader>xd", vim_cmd("Trouble lsp_document_diagnostics"), noremapSilent)
u.remap("n", "<leader>xl", vim_cmd("Trouble loclist"), noremapSilent)
u.remap("n", "<leader>xq", vim_cmd("Trouble quickfix"), noremapSilent)
u.remap("n", "<leader>qN", vim_cmd("lua require('trouble').previous({skip_groups = true, jump = true})"), noremapSilent)
u.remap("n", "<leader>qn", vim_cmd("lua require('trouble').next({skip_groups = true, jump = true})"), noremapSilent)

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
u.remap("n", "ss", "<cmd>lua require('substitute').line()<CR>", noremap)
u.remap("n", "S", "<cmd>lua require('substitute').eol()<CR>", noremap)

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
    c = { settings.toggle_colorcode_highlights, "Toggle colorcode highlights" },
  },
})

api.nvim_create_user_command("WQ", "wq", {})
api.nvim_create_user_command("Wq", "wq", {})
api.nvim_create_user_command("W", "w", {})
api.nvim_create_user_command("Qa", "qa", {})
api.nvim_create_user_command("Q", "q", {})
api.nvim_create_user_command("Lw", "w", {})

local function set_colorscheme(name)
  return function()
    theme.set_colorscheme(name)
  end
end

wk.register({
  ["<leader>t"] = {
    name = "theme",
    ["1"] = { set_colorscheme("mellifluous"), "mellifluous" },
    ["2"] = { set_colorscheme("duskfox"), "duskfox" },
    ["3"] = { set_colorscheme("base2tone_drawbridge_dark"), "drawbridge" },
    ["4"] = { set_colorscheme("no-clown-fiesta"), "no-clown-fiesta" },
    ["5"] = { set_colorscheme("tokyonight"), "tokyonight" },
    ["6"] = { set_colorscheme("nordfox"), "nord" },
  },
})

wk.register({
  ["<leader>l"] = {
    name = "LSP",
    i = { vim_cmd("TSToolsAddMissingImports"), "Add missing imports" },
    f = { vim_cmd("TSToolsFixAll"), "Fix all" },
    u = { vim_cmd("TSToolsRemoveUnused"), "Remove unused" },
  },
})
