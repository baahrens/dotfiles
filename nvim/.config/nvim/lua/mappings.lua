local g = vim.g
local api = vim.api
local lsp = require("plugin/lsp")
local theme_utils = require("plugin/colors/theme")

local u = require("util")
local t_builtin = require("telescope.builtin")
local t_themes = require("telescope.themes")
local settings = require("settings")
local notes = require("notes")
local wk = require("which-key")

local silent = { silent = true }
local noremap = { noremap = true }
local noremapSilent = { noremap = true, silent = true }

local function vim_cmd(cmd)
  return function()
    vim.cmd(cmd)
  end
end

-- map CMD on mac, Alt on linux
local function map_cmd_alt(key)
  if vim.g.is_macos then
    return "<D-" .. key .. ">"
  else
    return "<A-" .. key .. ">"
  end
end

local function find_dotfiles()
  return t_builtin.find_files(t_themes.get_dropdown({
    find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
    cwd = vim.g.dotfiles_dir,
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

api.nvim_create_user_command("WQ", "wq", {})
api.nvim_create_user_command("Wq", "wq", {})
api.nvim_create_user_command("W", "w", {})
api.nvim_create_user_command("Qa", "qa", {})
api.nvim_create_user_command("Q", "q", {})
api.nvim_create_user_command("Lw", "w", {})

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
u.remap("n", map_cmd_alt "j", "<C>move .+1<CR>", silent)
u.remap("n", map_cmd_alt "k", "<C>move .-2<CR>", silent)
u.remap("x", map_cmd_alt "j", ":move '>+1<CR>gv=gv", silent)
u.remap("x", map_cmd_alt "k", ":move '<-2<CR>gv=gv", silent)

-- delete in v mode without loosing current yank
u.remap("v", "<leader>p", '"_dP', noremap)
u.remap("v", "y", "ygv<ESC>", noremap)

-- nvim tree
-- u.remap("n", "<C-n>", vim_cmd("NvimTreeToggle"), noremap)
-- u.remap("n", "<C-b>", vim_cmd("NvimTreeFindFileToggle"), noremap)
u.remap("n", "<C-n>", function() require("oil").open(vim.fn.getcwd()) end, noremap)
u.remap("n", "<C-b>", function()
  require("oil").open(vim.fn.expand("%:p:h"))
end, noremap)

-- p <leader>o & <leader>O to newline without insert mode
u.remap("n", "<leader>o", ':<C-u>call append(line("."), repeat([""], v:count1))<CR>', noremapSilent)
u.remap("n", "<leader>O", ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>', noremapSilent)

vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)

wk.register({
  ["<leader>x"] = {
    name = "Open dir",
    p = { vim_cmd("Oil " .. vim.g.notes_dir .. "/private"), "Private notes" },
    w = { vim_cmd("Oil " .. vim.g.notes_dir .. "/work"), "Work notes" },
    t = { vim_cmd("Oil " .. vim.g.notes_dir.. "/tech"), "Tech notes" },
    d = { vim_cmd("Oil " .. vim.g.dotfiles_dir), "Dotfiles" },
  },
})

wk.register({
  ["<leader>n"] = {
    name = "notes",
    f = {
      p = { notes.grep_private, "private notes" },
      t = { notes.grep_tech, "tech notes" },
      d = { notes.grep_daily, "daily notes" },
    },
    d = { notes.open_daily, "open daily note" }
  }
})
wk.register({
  ["<leader>q"] = {
    name = "quickfix",
    c = { vim_cmd("cclose"), "Close" },
    o = { vim_cmd("copen"), "Open" },
    a = { vim_cmd("cc"), "" },
    n = { vim_cmd("cnext"), "next" },
    N = { vim_cmd("cprev"), "previous" }
  }
})

wk.register({
  ["<leader>g"] = {
    name = "git",
    s = { vim_cmd("Git"), "Status" },
    c = { vim_cmd("Git commit"), "Commit" },
    u = { vim_cmd("Git pull"), "Pull" },
    l = { vim_cmd("Git log"), "Log" },
    p = { vim_cmd("Git push"), "Push" },
    b = { vim_cmd("Git blame"), "Blame" },
    f = { vim_cmd("Gclog"), "File history" },
    A = { vim_cmd("Gitsigns stage_buffer"), "Stage buffer" },
    o = { vim_cmd("DiffviewOpen origin/master...HEAD"), "Diffview master" },
    m = { vim.cmd("Git switch master"), "Switch to master" },
    r = {
      name = "rebase",
      m = { vim_cmd("Git rebase -i origin/master"), "Rebase master" },
      c = { vim_cmd("Git rebase --continue"), "Rebase continue" },
      a = { vim_cmd("Git rebase --abort"), "Rebase abort" },
    },
    h = {
      name = "hunk",
      a = { vim_cmd("Gitsigns stage_hunk"), "Stage hunk", mode = { "v", "n" } },
      d = { vim_cmd("Gitsigns undo_stage_hunk"), "Undo stage hunk", mode = { "v", "n" } },
      r = { vim_cmd("Gitsigns reset_hunk"), "Reset hunk", mode = { "v", "n" } },
      s = { vim_cmd("Gitsigns preview_hunk"), "Preview hunk" },
      n = { vim_cmd("Gitsigns next_hunk"), "Next hunk" },
      N = { vim_cmd("Gitsigns prev_hunk"), "Previous hunk" },
    },
  },
})

u.remap("n", map_cmd_alt "p", t_builtin.find_files, noremap)
u.remap("n", "<C-p>", t_builtin.live_grep, noremap)
wk.register({
  ["<leader>f"] = {
    name = "find",
    d = { find_dotfiles, "dotfiles" },
    h = { t_builtin.help_tags, "help" },
    m = { t_builtin.keymaps, "mappings" },
    c = { t_builtin.commands, "commands" },
    i = { t_builtin.highlights, "highlights" },
    b = { t_builtin.buffers, "buffers" },
    s = { t_builtin.current_buffer_fuzzy_find, "fuzzy" },
    g = { t_builtin.git_branches, "branches" },
    x = { t_builtin.diagnostics, "diagnostics" },
    r = { t_builtin.resume, "Resume" },

  }
})

wk.register({
  ["<leader>c"] = {
    name = "LSP",
    r = { vim.lsp.buf.rename, "Rename" },
    c = { vim.lsp.buf.code_action, "Code action" },
    s = { vim.diagnostic.open_float, "Show diagnostic" },
    n = { vim.diagnostic.goto_next, "Next diagnostic" },
    N = { vim.diagnostic.goto_prev, "Previous diagnostic" },
    i = { vim_cmd("LspInfo"), "Info" },
    R = { vim_cmd("LspRestart"), "Restart LSP" },
    m = { vim_cmd("TSToolsAddMissingImports"), "Add missing imports" },
    f = { vim_cmd("TSToolsFixAll"), "Fix all" },
    u = { vim_cmd("TSToolsRemoveUnused"), "Remove unused" },
  }
})

u.remap("n", "gd", vim_cmd("Telescope lsp_definitions"), noremapSilent)
u.remap("n", "gD", vim_cmd("Telescope lsp_declarations"), noremapSilent)
u.remap("n", "K", vim.lsp.buf.hover, noremapSilent)
u.remap("v", "<C-f>", lsp.format, noremapSilent)
u.remap("n", "<C-f>", lsp.format, noremapSilent)
u.remap("n", "<leader>k", vim.lsp.buf.signature_help, noremapSilent)
u.remap("n", "<leader>d", vim_cmd("Glance references"), noremapSilent)

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
u.remap("n", "[", ":CybuLastusedPrev<CR>")
u.remap("n", "]", ":CybuLastusedNext<CR>")

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

u.remap("n", "<leader>nl", vim_cmd("Noice last"))
u.remap("n", "<leader>nm", vim_cmd("Noice history"))

u.remap("n", "<leader>t", theme_utils.switch_theme, noremap)
