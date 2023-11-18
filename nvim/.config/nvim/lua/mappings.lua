local u = require("util")
local wk = require("which-key")

local silent = { silent = true }
local noremap = { noremap = true }
local noremapSilent = { noremap = true, silent = true }

local function vim_cmd(cmd)
  return function()
    vim.cmd(cmd)
  end
end

vim.g.mapleader = " "

u.remap("n", " ", "", noremap)
u.remap("x", " ", "", noremap)

-- CR after search to turn off highlight
u.remap("n", "<CR>", ":noh<CR><CR>", noremap)

u.remap("n", "j", "gj", noremap)
u.remap("n", "k", "gk", noremap)

u.remap("n", "Q", ":q<CR>", noremap)
u.remap("n", "W", ":w<CR>", noremap)

vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Qa", "qa", {})
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("Lw", "w", {})

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
u.remap("n", "<M-j>", "<C>move .+1<CR>", silent)
u.remap("n", "<M-k", "<C>move .-2<CR>", silent)
u.remap("x", "<M-j>", ":move '>+1<CR>gv=gv", silent)
u.remap("x", "<M-k>", ":move '<-2<CR>gv=gv", silent)

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
    p = { vim_cmd("Oil " .. vim.g.notes_dir .. "/private"), "[dir] Private notes" },
    w = { vim_cmd("Oil " .. vim.g.notes_dir .. "/work"), "[dir] Work notes" },
    t = { vim_cmd("Oil " .. vim.g.notes_dir .. "/tech"), "Tech notes" },
    ["."] = { vim_cmd("Oil " .. vim.g.dotfiles_dir), "Dotfiles" },
  },
})

wk.register({
  ["<leader>n"] = {
    name = "notes",
    f = {
      name = "find",
      p = { function() require("notes").grep_private() end, "private notes" },
      t = { function() require("notes").grep_tech() end, "tech notes" },
      d = { function() require("notes").grep_daily() end, "daily notes" },
    },
    d = { function() require("notes").open_daily() end, "open daily note" }
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

u.remap("n", u.map_cmd_alt "p",
  function() require("plugin/telescope_pickers").find_files() end, noremap)
u.remap("n", "<C-p>", function() require("plugin/telescope_pickers").live_grep() end, noremap)
wk.register({
  ["<leader>f"] = {
    name = "find",
    h = { function() require("plugin/telescope_pickers").help() end, "Help" },
    m = { function() require("plugin/telescope_pickers").mappings() end, "Mappings" },
    c = { function() require("plugin/telescope_pickers").commands() end, "Commands" },
    i = { function() require("plugin/telescope_pickers").highlights() end, "Highlights" },
    b = { function() require("plugin/telescope_pickers").buffers() end, "Buffers" },
    s = { function() require("plugin/telescope_pickers").current_buffer() end, "Current buffer" },
    g = { function() require("plugin/telescope_pickers").branches() end, "Branches" },
    x = { function() require("plugin/telescope_pickers").diagnostics() end, "Diagnostics" },
    r = { function() require("plugin/telescope_pickers").resume() end, "Resume" },
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
u.remap("v", "<C-f>", function() require("plugin/lsp").format() end, noremapSilent)
u.remap("n", "<C-f>", function() require("plugin/lsp").format() end, noremapSilent)
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
    f = { function() require("settings").toggle_format_on_save() end, "Toggle on save formatting" },
    p = { function() require("settings").toggle_format_prettier() end, "Toggle prettier formatting" },
    e = { function() require("settings").toggle_format_eslint() end, "Toggle eslint formatting" },
    u = { function() require("settings").toggle_diagnostic_underline() end, "Toggle diagnostic underline" },
    v = { function() require("settings").toggle_diagnostic_virtual() end, "Toggle diagnostic virtual" },
    c = { function() require("settings").toggle_colorcode_highlights() end, "Toggle colorcode highlights" },
  },
})

u.remap("n", "<leader>nl", vim_cmd("Noice last"))
u.remap("n", "<leader>nm", vim_cmd("Noice history"))

u.remap('n', '<leader>m', function() require('treesj').toggle() end)

u.remap("n", "<leader>t", function() require("plugin/colors/theme").switch_theme() end, noremap)
