local g = vim.g
local api = vim.api
local telescope = require'plugin/telescope'
local lsp = require'plugin/lsp'
local u = require'util'

local silent = { silent = true }
local noremap = { noremap = true }
local noremapSilent = { noremap = true, silent = true }

g.mapleader = ' '

u.remap('n',' ','', noremap)
u.remap('x',' ','', noremap)

-- CR after search to turn off highlight
u.remap('n', '<CR>', ':noh<CR><CR>', noremap)

u.remap('n', 'j', 'gj', noremap)
u.remap('n', 'k', 'gk', noremap)

u.remap('n', 'Q', ':q<CR>', noremap)
u.remap('n', '<leader>ss', ':w<CR>', noremap) -- Alacritty: Command + s
u.remap('n', '<leader>f;', '/ <BS>', noremap) -- Alacritty: Command + f

-- H/L to go to beginning/end of the line
u.remap('n', 'H', '^', noremap)
u.remap('n', 'L', '$', noremap)

-- just kidding
u.remap('i', 'jk', '<ESC>', {})
u.remap('t', 'jk', '<ESC>', {})

-- keep visual selection when indenting
u.remap('v', '<', '<gv', noremap)
u.remap('v', '>', '>gv', noremap)

-- move lines in visual mode
u.remap('n', '<leader>z]', '<CMD>move .+1<CR>',   silent) -- Alacritty: Option + j
u.remap('n', '<leader>z[', '<CMD>move .-2<CR>',   silent) -- Alacritty: Option + k
u.remap('x', '<leader>z]', ":move '>+1<CR>gv=gv", silent) -- Alacritty: Option + j
u.remap('x', '<leader>z[', ":move '<-2<CR>gv=gv", silent) -- Alacritty: Option + k

-- delete in v mode without loosing current yank
u.remap('v', '<leader>p', '"_dP', noremap)
u.remap('v', 'y', 'ygv<ESC>', noremap)

-- shoutout
u.remap('n', '<leader>so', ':luafile %<CR>', noremap)

-- tmux
u.remap('n', '<C-h>', ':TmuxNavigateLeft<CR>',     noremapSilent)
u.remap('n', '<C-j>', ':TmuxNavigateDown<CR>',     noremapSilent)
u.remap('n', '<C-k>', ':TmuxNavigateUp<CR>',       noremapSilent)
u.remap('n', '<C-l>', ':TmuxNavigateRight<CR>',    noremapSilent)

-- nvim tree
u.remap('n', '<C-n>', ':NvimTreeToggle<CR>',   noremap)
u.remap('n', '<C-S-n>', ':NvimTreeFindFileToggle<CR>', noremap)

-- Map <leader>o & <leader>O to newline without insert mode
u.remap('n', '<leader>o', ':<C-u>call append(line("."), repeat([""], v:count1))<CR>', noremapSilent)
u.remap('n', '<leader>O', ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>', noremapSilent)

-- quickfix
u.remap("n", "<leader>qc", ":cclose<CR>", noremap)
u.remap("n", "<leader>qn", ":cnext<CR>",  noremap)
u.remap("n", "<leader>qo", ":copen<CR>",  noremap)
u.remap("n", "<leader>qp", ":cprev<CR>",  noremap)
u.remap("n", "<leader>qa", ":cc<CR>",     noremap)

-- locationlist
u.remap("n", "<leader>lc", ":lclose<CR>", noremap)
u.remap("n", "<leader>ln", ":lnext<CR>",  noremap)
u.remap("n", "<leader>lo", ":lopen<CR>",  noremap)
u.remap("n", "<leader>lp", ":lprev<CR>",  noremap)
u.remap("n", "<leader>la", ":ll<CR>",     noremap)

-- fugitive
u.remap('n', '<leader>gs',  ':Git<CR>', noremap)
u.remap('n', '<leader>gc',  ':Git commit<CR>', noremap)
u.remap('n', '<leader>gpl', ':Git pull<CR>', noremap)
u.remap('n', '<leader>gl',  ':Git log<CR>', noremap)
u.remap('n', '<leader>gp',  ':Git push<CR>', noremap)
u.remap('n', '<leader>gb',  ':Git blame<CR>', noremap)
u.remap('v', '<leader>ga',  ':Gitsigns stage_hunk<CR>', noremap)
u.remap('n', '<leader>ga',  ':Gitsigns stage_hunk<CR>', noremap)
u.remap('n', '<leader>gA',  ':Gitsigns stage_buffer<CR>', noremap)
u.remap('n', '<leader>gu',  ':Gitsigns undo_stage_hunk<CR>', noremap)
u.remap('n', '<leader>gg',  ':Gitsigns preview_hunk_inline<CR>', noremap)
u.remap('n', '<leader>gn',  ':Gitsigns next_hunk<CR>', noremap)
u.remap('n', '<leader>gN',  ':Gitsigns prev_hunk<CR>', noremap)

-- telescope
vim.keymap.set("n", "<leader>ff", telescope.find_files)
u.remap("n", "<C-p>",       telescope.grep_cwd,         noremap)
u.remap("n", "<leader>fn",  telescope.grep_notes,       noremap)
u.remap("n", "<leader>fd",  telescope.find_dotfiles,    noremap)
u.remap("n", "<leader>fh",  telescope.find_help,        noremap)
u.remap("n", "<leader>fm",  telescope.find_mappings,    noremap)
u.remap("n", "<leader>fc",  telescope.find_commands,    noremap)
u.remap("n", "<leader>fi",  telescope.find_highlights,  noremap)
u.remap("n", "<leader>fb",  telescope.find_buffers,     noremap)
u.remap("n", "<leader>fs",  telescope.fuzzy_find,       noremap)
u.remap("n", "<leader>fg",  telescope.git_branches,     noremap)
u.remap("n", "<leader>fx",  telescope.find_diagnostics, noremap)
u.remap("n", "<leader>fr",  telescope.resume,           noremap)

-- lsp/diagnostics/trouble
u.remap('n', 'gd',         '<cmd>Telescope lsp_definitions<CR>',         noremapSilent)
u.remap('n', 'gD',         '<cmd>Telescope lsp_declarations<CR>',        noremapSilent)
u.remap('n', 'gr',         '<cmd>Trouble lsp_references<CR>',            noremapSilent)
u.remap('n', 'K',          vim.lsp.buf.hover,                            noremapSilent)
u.remap('v', '<C-f>',      lsp.format,                                   noremapSilent)
u.remap('n', '<C-f>',      lsp.format,                                   noremapSilent)
u.remap('n', '<leader>cr', vim.lsp.buf.rename,                           noremapSilent)
u.remap('n', '<leader>ca', vim.lsp.buf.code_action,                      noremapSilent)
u.remap('n', "<leader>cs", vim.diagnostic.open_float,                    noremapSilent)
u.remap('n', '<leader>cn', vim.diagnostic.goto_next,                     noremapSilent)
u.remap('n', '<leader>cN', vim.diagnostic.goto_prev,                     noremapSilent)
u.remap('n', '<leader>cd', vim.diagnostic.get,                           noremapSilent)
u.remap('n', '<leader>k',  vim.lsp.buf.signature_help,                   noremapSilent)
u.remap('n', '<leader>d', '<cmd>Glance references<CR>',                  noremapSilent)
u.remap("n", "<leader>xx", "<cmd>Trouble<CR>",                           noremapSilent)
u.remap("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<CR>", noremapSilent)
u.remap("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<CR>",  noremapSilent)
u.remap("n", "<leader>xl", "<cmd>Trouble loclist<CR>",                   noremapSilent)
u.remap("n", "<leader>xq", "<cmd>Trouble quickfix<CR>",                  noremapSilent)
u.remap("n", "<leader>qN", "<cmd>lua require('trouble').previous({skip_groups = true, jump = true})<CR>", noremapSilent)
u.remap("n", "<leader>qn", "<cmd>lua require('trouble').next({skip_groups = true, jump = true})<CR>", noremapSilent)

-- search
u.remap('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'nzz')<CR><Cmd>lua require('hlslens').start()<CR>]], silent)
u.remap('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'Nzz')<CR><Cmd>lua require('hlslens').start()<CR>]], silent)
u.remap('n', '*', [[*zz<Cmd>lua require('hlslens').start()<CR>]], silent)
u.remap('n', '#', [[#zz<Cmd>lua require('hlslens').start()<CR>]], silent)
u.remap('n', 'g*', [[g*zz<Cmd>lua require('hlslens').start()<CR>]], silent)
u.remap('n', 'g#', [[g#zz<Cmd>lua require('hlslens').start()<CR>]], silent)
u.remap("n", "<C-d>", "<C-d>zz", noremapSilent)
u.remap("n", "<C-u>", "<C-u>zz", noremapSilent)

-- substitute
u.remap("n", "s", "<cmd>lua require('substitute').operator()<CR>", noremap)
u.remap("n", "ss", "<cmd>lua require('substitute').line()<CR>",    noremap)
u.remap("n", "S", "<cmd>lua require('substitute').eol()<CR>",      noremap)
u.remap("x", "s", "<cmd>lua require('substitute').visual()<CR>",   noremap)

-- cybu
u.remap("n", "<leader>zz", ":CybuLastusedPrev<CR>") -- Alacritty: Control + [
u.remap("n", "<leader>zx", ":CybuLastusedNext<CR>") -- Alacritty: Control + ]

u.remap('n', '<leader>j', require('treesj').toggle)

api.nvim_create_user_command('WQ', 'wq', {})
api.nvim_create_user_command('Wq', 'wq', {})
api.nvim_create_user_command('W', 'w', {})
api.nvim_create_user_command('Qa', 'qa', {})
api.nvim_create_user_command('Q', 'q', {})
api.nvim_create_user_command('Lw', 'w', {})
