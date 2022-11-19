local g = vim.g
local api = vim.api
local telescope = require'plugin/telescope'
local lsp = require'plugin/lsp'
local u = require'util'

g.mapleader = ' '

u.remap('n',' ','', { noremap = true })
u.remap('x',' ','', { noremap = true })

-- CR after search to turn off highlight
u.remap('n', '<CR>', ':noh<CR><CR>', { noremap = true })

u.remap('n', 'j', 'gj', { noremap = true })
u.remap('n', 'k', 'gk', { noremap = true })

u.remap('n', 'Q', ':q<CR>', { noremap = true })
u.remap('n', '<leader>ss', ':w<CR>', { noremap = true }) -- Alacritty: Command + s
u.remap('n', '<leader>f;', '/ <BS>', { noremap = true }) -- Alacritty: Command + f

api.nvim_create_user_command('WQ', 'wq', {})
api.nvim_create_user_command('Wq', 'wq', {})
api.nvim_create_user_command('W', 'w', {})
api.nvim_create_user_command('Qa', 'qa', {})
api.nvim_create_user_command('Q', 'q', {})
api.nvim_create_user_command('Lw', 'w', {})

-- H/L to go to beginning/end of the line
u.remap('n', 'H', '^', { noremap = true })
u.remap('n', 'L', '$', { noremap = true })

-- just kidding
u.remap('i', 'jk', '<ESC>', {})
u.remap('t', 'jk', '<ESC>', {})

-- keep visual selection when indenting
u.remap('v', '<', '<gv', { noremap = true })
u.remap('v', '>', '>gv', { noremap = true })

-- move lines in visual mode
u.remap('n', '<leader>z]', '<CMD>move .+1<CR>',   { silent = true }) -- Alacritty: Option + j
u.remap('n', '<leader>z[', '<CMD>move .-2<CR>',   { silent = true }) -- Alacritty: Option + k
u.remap('x', '<leader>z]', ":move '>+1<CR>gv=gv", { silent = true }) -- Alacritty: Option + j
u.remap('x', '<leader>z[', ":move '<-2<CR>gv=gv", { silent = true }) -- Alacritty: Option + k

-- delete in v mode without loosing current yank
u.remap('v', '<leader>p', '"_dP', { noremap = true })

-- shoutout
u.remap('n', '<leader>so', ':luafile %<CR>', { noremap = true })

-- tmux
u.remap('n', '<C-h>', ':TmuxNavigateLeft<CR>',     { noremap = true, silent = true })
u.remap('n', '<C-j>', ':TmuxNavigateDown<CR>',     { noremap = true, silent = true })
u.remap('n', '<C-k>', ':TmuxNavigateUp<CR>',       { noremap = true, silent = true })
u.remap('n', '<C-l>', ':TmuxNavigateRight<CR>',    { noremap = true, silent = true })

-- nvim tree
u.remap('n', '<C-n>', ':NvimTreeToggle<CR>',        { noremap = true })
u.remap('n', '<leader>r', ':NvimTreeRefresh<CR>',   { noremap = true })
u.remap('n', '<leader>nf', ':NvimTreeFindFile<CR>', { noremap = true })

-- Map <leader>o & <leader>O to newline without insert mode
u.remap('n', '<leader>o', ':<C-u>call append(line("."), repeat([""], v:count1))<CR>', { noremap = true, silent = true })
u.remap('n', '<leader>O', ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>', { noremap = true, silent = true })

-- quickfix
u.remap("n", "<leader>qc", ":cclose<CR>", { noremap = true })
u.remap("n", "<leader>qn", ":cnext<CR>",  { noremap = true })
u.remap("n", "<leader>qo", ":copen<CR>",  { noremap = true })
u.remap("n", "<leader>qp", ":cprev<CR>",  { noremap = true })
u.remap("n", "<leader>qa", ":cc<CR>",     { noremap = true })

-- locationlist
u.remap("n", "<leader>lc", ":lclose<CR>", { noremap = true })
u.remap("n", "<leader>ln", ":lnext<CR>",  { noremap = true })
u.remap("n", "<leader>lo", ":lopen<CR>",  { noremap = true })
u.remap("n", "<leader>lp", ":lprev<CR>",  { noremap = true })
u.remap("n", "<leader>la", ":ll<CR>",     { noremap = true })

-- fugitive
u.remap('n', '<leader>gs',  ':Git<CR>',        { noremap = true })
u.remap('n', '<leader>gc',  ':Git commit<CR>', { noremap = true })
u.remap('n', '<leader>gpl', ':Git pull<CR>',   { noremap = true })
u.remap('n', '<leader>gl',  ':Git log<CR>',    { noremap = true })
u.remap('n', '<leader>gp',  ':Git push<CR>',   { noremap = true })
u.remap('n', '<leader>gb',  ':Git blame<CR>',  { noremap = true })

-- telescope
vim.keymap.set("n", "<leader>ff", telescope.find_files)
-- u.remap("n", "<leader>ff",  "<cmd>lua require('plugin.telescope').find_files()<CR>",       { noremap = true }) -- Alacritty: Command + p
u.remap("n", "<C-p>",       telescope.grep_cwd,         { noremap = true })
u.remap("n", "<leader>fn",  telescope.grep_notes,       { noremap = true })
u.remap("n", "<leader>fd",  telescope.find_dotfiles,    { noremap = true })
u.remap("n", "<leader>fh",  telescope.find_help,        { noremap = true })
u.remap("n", "<leader>fm",  telescope.find_mappings,    { noremap = true })
u.remap("n", "<leader>fc",  telescope.find_commands,    { noremap = true })
u.remap("n", "<leader>fi",  telescope.find_highlights,  { noremap = true })
u.remap("n", "<leader>fb",  telescope.find_buffers,     { noremap = true })
u.remap("n", "<leader>fs",  telescope.fuzzy_find,       { noremap = true })
u.remap("n", "<leader>fg",  telescope.git_branches,     { noremap = true })
u.remap("n", "<leader>fx",  telescope.find_diagnostics, { noremap = true })
u.remap("n", "<leader>fr",  telescope.resume,           { noremap = true })

-- lsp/diagnostics/trouble
u.remap('n', 'gd',         '<cmd>Telescope lsp_definitions<CR>',         { noremap = true, silent = true })
u.remap('n', 'gD',         '<cmd>Telescope lsp_declarations<CR>',        { noremap = true, silent = true })
u.remap('n', 'gr',         '<cmd>Telescope lsp_references<CR>',          { noremap = true, silent = true })
u.remap('n', 'gR',         '<cmd>Trouble lsp_references<CR>',            { noremap = true, silent = true })
u.remap('n', 'K',          vim.lsp.buf.hover,                            { noremap = true, silent = true })
u.remap('n', '<leader>cf', lsp.format,                                   { noremap = true, silent = true })
u.remap('n', '<leader>cr', vim.lsp.buf.rename,                           { noremap = true, silent = true })
u.remap('n', '<leader>ca', vim.lsp.buf.code_action,                      { noremap = true, silent = true })
u.remap('n', "<leader>cs", vim.diagnostic.open_float,                    { noremap = true, silent = true })
u.remap('n', '<leader>cn', vim.diagnostic.goto_next,                     { noremap = true, silent = true })
u.remap('n', '<leader>cN', vim.diagnostic.goto_prev,                     { noremap = true, silent = true })
u.remap('n', '<leader>cd', vim.diagnostic.get,                           { noremap = true, silent = true })
u.remap("n", "<leader>xx", "<cmd>Trouble<CR>",                           { silent = true, noremap = true })
u.remap("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<CR>", { silent = true, noremap = true })
u.remap("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<CR>",  { silent = true, noremap = true })
u.remap("n", "<leader>xl", "<cmd>Trouble loclist<CR>",                   { silent = true, noremap = true })
u.remap("n", "<leader>xq", "<cmd>Trouble quickfix<CR>",                  { silent = true, noremap = true })

-- search
u.remap('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'nzz')<CR><Cmd>lua require('hlslens').start()<CR>]], { silent = true })
u.remap('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'Nzz')<CR><Cmd>lua require('hlslens').start()<CR>]], { silent = true })
u.remap('n', '*', [[*zz<Cmd>lua require('hlslens').start()<CR>]], { silent = true })
u.remap('n', '#', [[#zz<Cmd>lua require('hlslens').start()<CR>]], { silent = true })
u.remap('n', 'g*', [[g*zz<Cmd>lua require('hlslens').start()<CR>]], { silent = true })
u.remap('n', 'g#', [[g#zz<Cmd>lua require('hlslens').start()<CR>]], { silent = true })
u.remap("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
u.remap("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

-- substitute
u.remap("n", "s", "<cmd>lua require('substitute').operator()<CR>", { noremap = true })
u.remap("n", "ss", "<cmd>lua require('substitute').line()<CR>",    { noremap = true })
u.remap("n", "S", "<cmd>lua require('substitute').eol()<CR>",      { noremap = true })
u.remap("x", "s", "<cmd>lua require('substitute').visual()<CR>",   { noremap = true })

-- cybu
u.remap("n", "<leader>zz", ":CybuLastusedPrev<CR>") -- Alacritty: Control + [
u.remap("n", "<leader>zx", ":CybuLastusedNext<CR>") -- Alacritty: Control + ]
