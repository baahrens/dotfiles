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

-- File explorer
u.remap("n", "<C-n>", function() require("oil").open(vim.fn.getcwd()) end, noremap)
u.remap("n", "<C-b>", function()
  require("oil").open(vim.fn.expand("%:p:h"))
end, noremap)

-- leader mappings
wk.add({
  { "<leader>o",   ':<C-u>call append(line("."), repeat([""], v:count1))<CR>',          desc = "New line below" },
  { "<leader>O",   ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>',        desc = "New line above" },
  { "<leader>m",   function() require('treesj').toggle() end,                           desc = "Split/Join lines" },
  { "<leader>t",   function() require("plugin/colors/theme").switch_theme() end,        desc = "Switch theme" },
  { "<leader>k",   vim.lsp.buf.signature_help,                                          desc = "Signature Help" },
  { "<leader>d",   vim_cmd("Glance references"),                                        desc = "Show References" },

  { "<leader>x",   group = "Open dir" },
  { "<leader>xp",  vim_cmd("Oil " .. vim.g.notes_dir .. "/private"),                    desc = "[dir] Private notes" },
  { "<leader>xw",  vim_cmd("Oil " .. vim.g.notes_dir .. "/work"),                       desc = "[dir] Work notes" },
  { "<leader>xt",  vim_cmd("Oil " .. vim.g.notes_dir .. "/tech"),                       desc = "Tech notes" },
  { "<leader>x.",  vim_cmd("Oil " .. vim.g.dotfiles_dir),                               desc = "Dotfiles" },

  { "<leader>n",   group = "notes" },
  { "<leader>nf",  group = "find" },
  { "<leader>nfp", function() require("notes").grep_private() end,                      desc = "private notes" },
  { "<leader>nft", function() require("notes").grep_tech() end,                         desc = "tech notes" },
  { "<leader>nfd", function() require("notes").grep_daily() end,                        desc = "daily notes" },
  { "<leader>nd",  function() require("notes").open_daily() end,                        desc = "open daily note" },

  { "<leader>q",   group = "quickfix" },
  { "<leader>qc",  vim_cmd("cclose"),                                                   desc = "Close" },
  { "<leader>qo",  vim_cmd("copen"),                                                    desc = "Open" },
  { "<leader>qa",  vim_cmd("cc"),                                                       desc = "" },
  { "<leader>qn",  vim_cmd("cnext"),                                                    desc = "next" },
  { "<leader>qN",  vim_cmd("cprev"),                                                    desc = "previous" },

  { "<leader>g",   group = "git" },
  { "<leader>gs",  function() require("plugin/fugitive").git_status() end,              desc = "Status" },
  { "<leader>gl",  function() require("plugin/fugitive").git_log() end,                 desc = "Log" },
  { "<leader>gc",  vim_cmd("Git commit"),                                               desc = "Commit" },
  { "<leader>gu",  vim_cmd("Git pull"),                                                 desc = "Pull" },
  { "<leader>gp",  vim_cmd("Git push"),                                                 desc = "Push" },
  { "<leader>gb",  vim_cmd("Git blame"),                                                desc = "Blame" },
  { "<leader>gf",  vim_cmd("Gclog"),                                                    desc = "File history" },
  { "<leader>ga",  vim_cmd("Gitsigns stage_buffer"),                                    desc = "Stage buffer" },
  { "<leader>go",  vim_cmd("DiffviewOpen origin/master...HEAD"),                        desc = "Diffview master" },
  { "<leader>gm",  vim_cmd("Git switch master"),                                        desc = "Switch to master" },

  { "<leader>gr",  group = "rebase" },
  { "<leader>grm", vim_cmd("Git rebase -i origin/master"),                              desc = "Rebase master" },
  { "<leader>grc", vim_cmd("Git rebase --continue"),                                    desc = "Rebase continue" },
  { "<leader>gra", vim_cmd("Git rebase --abort"),                                       desc = "Rebase abort" },

  { "<leader>gh",  group = "hunk" },
  { "<leader>gha", vim_cmd("Gitsigns stage_hunk"),                                      desc = "Stage hunk",                 mode = { "v", "n" } },
  { "<leader>ghd", vim_cmd("Gitsigns undo_stage_hunk"),                                 desc = "Undo stage hunk",            mode = { "v", "n" } },
  { "<leader>ghr", vim_cmd("Gitsigns reset_hunk"),                                      desc = "Reset hunk",                 mode = { "v", "n" } },
  { "<leader>ghs", vim_cmd("Gitsigns preview_hunk"),                                    desc = "Preview hunk" },
  { "<leader>ghn", vim_cmd("Gitsigns next_hunk"),                                       desc = "Next hunk" },
  { "<leader>ghN", vim_cmd("Gitsigns prev_hunk"),                                       desc = "Previous hunk" },

  { "<leader>f",   group = "find" },
  { "<leader>fh",  function() require("plugin/telescope_pickers").help() end,           desc = "Help" },
  { "<leader>fm",  function() require("plugin/telescope_pickers").mappings() end,       desc = "Mappings" },
  { "<leader>fc",  function() require("plugin/telescope_pickers").commands() end,       desc = "Commands" },
  { "<leader>fi",  function() require("plugin/telescope_pickers").highlights() end,     desc = "Highlights" },
  { "<leader>fb",  function() require("plugin/telescope_pickers").buffers() end,        desc = "Buffers" },
  { "<leader>fs",  function() require("plugin/telescope_pickers").current_buffer() end, desc = "Current buffer" },
  { "<leader>fg",  function() require("plugin/telescope_pickers").branches() end,       desc = "Branches" },
  { "<leader>fx",  function() require("plugin/telescope_pickers").diagnostics() end,    desc = "Diagnostics" },
  { "<leader>fr",  function() require("plugin/telescope_pickers").resume() end,         desc = "Resume" },

  { "<leader>c",   group = "lsp" },
  { "<leader>cr",  vim.lsp.buf.rename,                                                  desc = "Rename" },
  { "<leader>cc",  vim.lsp.buf.code_action,                                             desc = "Code action" },
  { "<leader>cs",  vim.diagnostic.open_float,                                           desc = "Show diagnostic" },
  { "<leader>cn",  vim.diagnostic.goto_next,                                            desc = "Next diagnostic" },
  { "<leader>cN",  vim.diagnostic.goto_prev,                                            desc = "Previous diagnostic" },
  { "<leader>ci",  vim_cmd("LspInfo"),                                                  desc = "Info" },
  { "<leader>cR",  vim_cmd("LspRestart"),                                               desc = "Restart LSP" },
  { "<leader>cm",  vim_cmd("TSToolsAddMissingImports"),                                 desc = "Add missing imports" },
  { "<leader>cf",  vim_cmd("TSToolsFixAll"),                                            desc = "Fix all" },
  { "<leader>cu",  vim_cmd("TSToolsRemoveUnused"),                                      desc = "Remove unused" },

  { "<leader>s",   group = "settings" },
  { "<leader>sf",  function() require("settings").toggle_format_on_save() end,          desc = "Toggle on save formatting" },
  { "<leader>sp",  function() require("settings").toggle_format_prettier() end,         desc = "Toggle prettier formatting" },
  { "<leader>se",  function() require("settings").toggle_format_eslint() end,           desc = "Toggle eslint formatting" },
  { "<leader>su",  function() require("settings").toggle_diagnostic_underline() end,    desc = "Toggle diagnostic underline" },
  { "<leader>sv",  function() require("settings").toggle_diagnostic_virtual() end,      desc = "Toggle diagnostic virtual" },
  { "<leader>sc",  function() require("settings").toggle_colorcode_highlights() end,    desc = "Toggle colorcode highlights" },

  { "<leader>h",   group = "build" },
  { "<leader>hs",  vim_cmd("OverseerToggle"),                                           desc = "Show" },
  { "<leader>hr",  vim_cmd("OverseerRun"),                                              desc = "Run" },
})

vim.keymap.set('n', "<C-a>", "<CMD>OverseerToggle<CR>")

vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)

u.remap("n", u.map_cmd_alt "CR", ":vsplit<CR>", noremap)
u.remap("n", u.map_cmd_alt "p",
  function() require("plugin/telescope_pickers").find_files() end, noremap)
u.remap("n", "<C-p>", function() require("plugin/telescope_pickers").live_grep() end, noremap)
u.remap("n", "gd", vim.lsp.buf.definition, noremapSilent)
u.remap("n", "gD", "<cmd>vsplit +v:lua.vim.lsp.buf.definition()<CR>", noremapSilent)
u.remap("n", "K", vim.lsp.buf.hover, noremapSilent)
u.remap("v", "<C-f>", function() require("plugin/lsp").format() end, noremapSilent)
u.remap("n", "<C-f>", function() require("plugin/lsp").format() end, noremapSilent)

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
