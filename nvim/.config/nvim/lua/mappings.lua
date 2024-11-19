---@diagnostic disable: undefined-field
local u = require("util")
local wk = require("which-key")

local M = {}

local function vim_cmd(cmd)
  return function()
    vim.cmd(cmd)
  end
end

M.common = {
  open_vsplit = u.map_cmd_alt("CR"),
  select_next = u.map_cmd_alt("j"),
  select_prev = u.map_cmd_alt("k"),
  scroll_up = "<C-u>",
  scroll_down = "<C-d>"
}

---@diagnostic disable-next-line: inject-field
vim.g.mapleader = " "

wk.add({
  { "<leader>o",          ':<C-u>call append(line("."), repeat([""], v:count1))<CR>',                                desc = "New line below" },
  { "<leader>O",          ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>',                              desc = "New line above" },
  { "<leader>m",          function() require('treesj').toggle() end,                                                 desc = "Split/Join lines" },
  { "<leader>t",          function() require("plugin/colors/theme").switch_theme() end,                              desc = "Switch theme" },
  { "<leader>k",          vim.lsp.buf.signature_help,                                                                desc = "Signature Help" },
  { "<leader>d",          vim_cmd("Glance references"),                                                              desc = "Show References" },

  { "<leader>x",          group = "Open dir" },
  { "<leader>xp",         vim_cmd("Oil " .. vim.g.notes_dir .. "/private"),                                          desc = "Private notes" },
  { "<leader>xw",         vim_cmd("Oil " .. vim.g.notes_dir .. "/work"),                                             desc = "Work notes" },
  { "<leader>xt",         vim_cmd("Oil " .. vim.g.notes_dir .. "/tech"),                                             desc = "Tech notes" },
  { "<leader>x.",         vim_cmd("Oil " .. vim.g.dotfiles_dir),                                                     desc = "Dotfiles" },
  { "<C-n>",              function() require("oil").open(vim.fn.getcwd()) end },
  { "<C-b>",              function() require("oil").open(vim.fn.expand("%:p:h")) end },

  { "<leader>n",          group = "notes" },
  { "<leader>nf",         function() require("notes").grep_notes() end,                                              desc = "Private notes" },
  { "<leader>nd",         function() require("notes").open_daily() end,                                              desc = "Open daily note" },

  { "<leader>q",          group = "quickfix" },
  { "<leader>qc",         vim_cmd("cclose"),                                                                         desc = "Close" },
  { "<leader>qo",         vim_cmd("copen"),                                                                          desc = "Open" },
  { "<leader>qa",         vim_cmd("cc"), },
  { "<leader>qn",         vim_cmd("cnext"),                                                                          desc = "Next" },
  { "<leader>qN",         vim_cmd("cprev"),                                                                          desc = "Previous" },

  { "<leader>g",          group = "git" },
  { "<leader>gs",         function() require("plugin/fugitive").status() end,                                        desc = "Status" },
  { "<leader>gl",         function() require("plugin/fugitive").log() end,                                           desc = "Log" },
  { "<leader>gc",         vim_cmd("Git commit"),                                                                     desc = "Commit" },
  { "<leader>gu",         vim_cmd("Git pull"),                                                                       desc = "Pull" },
  { "<leader>gp",         vim_cmd("Git push"),                                                                       desc = "Push" },
  { "<leader>gb",         vim_cmd("Git blame"),                                                                      desc = "Blame" },
  { "<leader>gf",         vim_cmd("DiffviewFileHistory"),                                                            desc = "File history" },
  { "<leader>ga",         vim_cmd("Gitsigns stage_buffer"),                                                          desc = "Stage buffer" },
  { "<leader>go",         vim_cmd("DiffviewOpen"),                                                                   desc = "Diffview master" },
  { "<leader>gm",         vim_cmd("Git switch master"),                                                              desc = "Switch to master" },
  { "<leader>g-",         vim_cmd("Git switch -"),                                                                   desc = "Switch back" },
  { "<leader>gr",         vim_cmd("Git reset HEAD^"),                                                                desc = "Reset HEAD^" },
  { "<leader>gR",         function() require("plugin/fugitive").reset_hard() end,                                    desc = "Reset hard master" },
  { "<leader>gn",         function() require("plugin/fugitive").new_branch() end,                                    desc = "Switch to new branch" },

  { "<leader>gr",         group = "rebase" },
  { "<leader>grm",        vim_cmd("Git rebase -i origin/master"),                                                    desc = "Rebase master" },
  { "<leader>grc",        vim_cmd("Git rebase --continue"),                                                          desc = "Rebase continue" },
  { "<leader>gra",        vim_cmd("Git rebase --abort"),                                                             desc = "Rebase abort" },

  { "<leader>gh",         group = "hunk" },
  { "<leader>gha",        vim_cmd("Gitsigns stage_hunk"),                                                            mode = { "v", "n" },                 desc = "Stage hunk", },
  { "<leader>ghd",        vim_cmd("Gitsigns undo_stage_hunk"),                                                       mode = { "v", "n" },                 desc = "Undo stage hunk", },
  { "<leader>ghr",        vim_cmd("Gitsigns reset_hunk"),                                                            mode = { "v", "n" },                 desc = "Reset hunk", },
  { "<leader>ghs",        vim_cmd("Gitsigns preview_hunk"),                                                          desc = "Preview hunk" },
  { "<leader>ghn",        vim_cmd("Gitsigns next_hunk"),                                                             desc = "Next hunk" },
  { "<leader>ghN",        vim_cmd("Gitsigns prev_hunk"),                                                             desc = "Previous hunk" },

  { "<leader>f",          group = "find" },
  { "<leader>fh",         function() require("plugin/telescope_pickers").help() end,                                 desc = "Help" },
  { "<leader>fm",         function() require("plugin/telescope_pickers").mappings() end,                             desc = "Mappings" },
  { "<leader>fc",         function() require("plugin/telescope_pickers").commands() end,                             desc = "Commands" },
  { "<leader>fi",         function() require("plugin/telescope_pickers").highlights() end,                           desc = "Highlights" },
  { "<leader>fb",         function() require("plugin/telescope_pickers").buffers() end,                              desc = "Buffers" },
  { "<leader>fs",         function() require("plugin/telescope_pickers").current_buffer() end,                       desc = "Current buffer" },
  { "<leader>fg",         function() require("plugin/telescope_pickers").branches() end,                             desc = "Branches" },
  { "<leader>fx",         function() require("plugin/telescope_pickers").diagnostics() end,                          desc = "Diagnostics" },
  { "<leader>fr",         function() require("plugin/telescope_pickers").resume() end,                               desc = "Resume" },
  { u.map_cmd_alt("o"),   function() require("plugin/telescope_pickers").old_files() end,                            desc = "Old files" },
  { u.map_cmd_alt "p",    function() require("plugin/telescope_pickers").find_files() end,                           desc = "Files" },
  { "<C-p>",              function() require("plugin/telescope_pickers").live_grep() end,                            desc = "Live grep" },

  { "<leader>c",          group = "lsp" },
  { "<leader>cr",         vim.lsp.buf.rename,                                                                        desc = "Rename" },
  { "<leader>cc",         vim.lsp.buf.code_action,                                                                   desc = "Code action" },
  { "<leader>cs",         vim.diagnostic.open_float,                                                                 desc = "Show diagnostic" },
  { "<leader>cn",         function() vim.diagnostic.jump { count = 1 } end,                                          desc = "Next diagnostic" },
  { "<leader>cN",         function() vim.diagnostic.jump { count = -1 } end,                                         desc = "Previous diagnostic" },
  { "<leader>ci",         vim_cmd("LspInfo"),                                                                        desc = "Info" },
  { "<leader>cR",         vim_cmd("LspRestart"),                                                                     desc = "Restart LSP" },
  { "<leader>cm",         vim_cmd("TSToolsAddMissingImports"),                                                       desc = "Add missing imports" },
  { "<leader>cf",         vim_cmd("TSToolsFixAll"),                                                                  desc = "Fix all" },
  { "<leader>cu",         vim_cmd("TSToolsRemoveUnused"),                                                            desc = "Remove unused" },
  { "gd",                 vim.lsp.buf.definition },
  { "gD",                 '<Cmd>vs<CR><Cmd>lua vim.lsp.buf.definition()<CR>' },
  { "K",                  vim.lsp.buf.hover },
  { "<C-f>",              function() require("plugin/lsp").format() end,                                             mode = { "n", "v" } },

  { "<leader>s",          group = "settings" },
  { "<leader>sf",         function() require("settings").toggle_format_on_save() end,                                desc = "Toggle on save formatting" },
  { "<leader>sp",         function() require("settings").toggle_format_prettier() end,                               desc = "Toggle prettier formatting" },
  { "<leader>se",         function() require("settings").toggle_format_eslint() end,                                 desc = "Toggle eslint formatting" },
  { "<leader>su",         function() require("settings").toggle_diagnostic_underline() end,                          desc = "Toggle diagnostic underline" },
  { "<leader>sv",         function() require("settings").toggle_diagnostic_virtual() end,                            desc = "Toggle diagnostic virtual" },
  { "<leader>sc",         function() require("settings").toggle_colorcode_highlights() end,                          desc = "Toggle colorcode highlights" },

  { "<leader>h",          group = "build" },
  { "<leader>hs",         vim_cmd("OverseerToggle"),                                                                 desc = "Show" },
  { "<leader>hr",         vim_cmd("OverseerRun"),                                                                    desc = "Run" },

  { "<leader>a",          group = "AI" },
  { "<leader>aa",         vim_cmd("CopilotChatToggle"),                                                              mode = { "n", "v" },                 desc = "Toggle Chat" },
  { "<leader>ae",         vim_cmd("CopilotChatExplain"),                                                             mode = { "n", "v" },                 desc = "Explain" },
  { "<leader>ar",         vim_cmd("CopilotChatReview"),                                                              mode = { "n", "v" },                 desc = "Review" },
  { "<leader>at",         vim_cmd("CopilotChatTests"),                                                               mode = { "n", "v" },                 desc = "Tests" },
  { "<leader>ao",         vim_cmd("CopilotChatOptimize"),                                                            mode = { "n", "v" },                 desc = "Optimize" },

  { '<C-h>',              require('smart-splits').move_cursor_left },
  { '<C-j>',              require('smart-splits').move_cursor_down },
  { '<C-k>',              require('smart-splits').move_cursor_up },
  { '<C-l>',              require('smart-splits').move_cursor_right },

  { "<C-a>",              "<CMD>OverseerToggle<CR>" },

  { M.common.open_vsplit, ":vsplit<CR>" },

  -- search
  { "n",                  [[<Cmd>execute('normal! ' . v:count1 . 'nzz')<CR><Cmd>lua require('hlslens').start()<CR>]] },
  { "N",                  [[<Cmd>execute('normal! ' . v:count1 . 'Nzz')<CR><Cmd>lua require('hlslens').start()<CR>]] },
  { "*",                  [[*zz<Cmd>lua require('hlslens').start()<CR>]] },
  { "#",                  [[#zz<Cmd>lua require('hlslens').start()<CR>]] },
  { "g*",                 [[g*zz<Cmd>lua require('hlslens').start()<CR>]] },
  { "g#",                 [[g#zz<Cmd>lua require('hlslens').start()<CR>]] },
  { "<C-d>",              "<C-d>zz" },
  { "<C-u>",              "<C-u>zz" },
  { "<CR>",               ":noh<CR><CR>" },

  { "ss",                 "<cmd>lua require('substitute').line()<CR>" },
  { "S",                  "<cmd>lua require('substitute').eol()<CR>" },
  { "s",                  "<cmd>lua require('substitute').operator()<CR>" },
  { "s",                  "<cmd>lua require('substitute').visual()<CR>",                                             mode = "x" },

  { "j",                  "gj" },
  { "k",                  "gk" },

  { "Q",                  ":q<CR>" },
  { u.map_cmd_alt("W"),   ":w<CR>" },

  { "H",                  "^",                                                                                       mode = { "n", "x" } },
  { "L",                  "$",                                                                                       mode = { "n", "x" } },

  -- move back and forth in insert mode
  { "<C-h>",              "<C-O>h",                                                                                  mode = "i" },
  { "<C-l>",              "<C-O>a",                                                                                  mode = "i" },

  { "jk",                 "<ESC>",                                                                                   mode = "i" },
  { "jk",                 "<ESC>",                                                                                   mode = "i" },

  -- keep visual selection when indenting
  { "<",                  "<gv",                                                                                     mode = "v" },
  { ">",                  ">gv",                                                                                     mode = "v" },

  -- move lines in visual mode
  { "<M-j>",              "<C>move .+1<CR>" },
  { "<M-k",               "<C>move .-2<CR>" },
  { "<M-j>",              ":move '>+1<CR>gv=gv",                                                                     mode = "x" },
  { "<M-k>",              ":move '<-2<CR>gv=gv",                                                                     mode = "x" },

  -- delete in v mode without loosing current yank
  { "<leader>p",          '"_dP',                                                                                    mode = "v" },
  { "y",                  "ygv<ESC>",                                                                                mode = "v" },
})

return M
