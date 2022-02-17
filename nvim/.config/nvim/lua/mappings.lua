local g = vim.g
local telescope = require'plugin/telescope'
local toggleterm = require'plugin/toggleterm'
local u = require'util'

g.mapleader = ' '
u.remap('n',' ','', { noremap = true })

u.remap('x',' ','', { noremap = true })

-- CR after search to turn off highlight
u.remap('n', '<CR>', ':noh<CR><CR>', { noremap = true })

u.remap('n', 'j', 'gj', { noremap = true })
u.remap('n', 'k', 'gk', { noremap = true })

u.remap('n', 'Q', ':q<CR>', { noremap = true })

-- center search results + center after scrolling
u.remap('n', 'n', 'nzz', { noremap = true, silent = true })
u.remap('n', 'N', 'Nzz', { noremap = true, silent = true })
u.remap('n', '*', '*zz', { noremap = true, silent = true })
u.remap('n', '#', '#zz', { noremap = true, silent = true })
u.remap('n', 'g*', 'g*zz', { noremap = true, silent = true })
u.remap('n', 'G', 'Gzz', { noremap = true, silent = true })
u.remap("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
u.remap("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

-- Move lines
u.remap('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true })
u.remap('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true })

-- H/L to go to beginning/end of the line
u.remap('n', 'H', '^', { noremap = true })
u.remap('n', 'L', '$', { noremap = true })

-- just kidding
u.remap('i', 'jk', '<ESC>', {})
u.remap('t', 'jk', '<ESC>', {})

-- use tab/s-tab to navigate search results while still being able to refine search
u.remap('c', '<Tab>', "getcmdtype() =~ '[/?]' ? '<C-g>' : '<C-z>'", { expr = true, noremap = true })
u.remap('c', '<S-Tab>', "getcmdtype() =~ '[/?]' ? '<C-t>' : '<S-Tab>'", { expr = true, noremap = true })

-- buffer management
u.remap('n', '<leader>b', ':ls<CR>:b<space>', { noremap = true })
u.remap('n', '<Tab>',     ':bprevious<CR>',       { noremap = true, silent = true })
u.remap('n', '<S-Tab>',   ':bnext<CR>',   { noremap = true, silent = true })

-- keep visual selection when indenting
u.remap('v', '<', '<gv', { noremap = true })
u.remap('v', '>', '>gv', { noremap = true })

-- tmux
u.remap('n', '<C-h>', ':TmuxNavigateLeft<CR>', { noremap = true, silent = true })
u.remap('n', '<C-j>', ':TmuxNavigateDown<CR>', { noremap = true, silent = true })
u.remap('n', '<C-k>', ':TmuxNavigateUp<CR>', { noremap = true, silent = true })
u.remap('n', '<C-l>', ':TmuxNavigateRight<CR>', { noremap = true, silent = true })
u.remap('n', '<C-ö>', ':TmuxNavigatePrevious<CR>', { noremap = true, silent = true })

-- nvim tree
u.remap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true })
u.remap('n', '<leader>r', ':NvimTreeRefresh<CR>', { noremap = true })
u.remap('n', '<leader>nf', ':NvimTreeFindFile<CR>', { noremap = true })

-- delete in v mode without loosing current yank
u.remap('v', '<leader>p', '"_dP', { noremap = true })

-- shoutout
u.remap('n', '<leader>so', ':so %<CR>', { noremap = true })

-- search
u.remap('n', '<leader><space>', '/', { noremap = true })
u.remap('n', 's', '/', { noremap = true })

-- Map <leader>o & <leader>O to newline without insert mode
u.remap('n', '<leader>o', ':<C-u>call append(line("."), repeat([""], v:count1))<CR>', { noremap = true, silent = true })
u.remap('n', '<leader>O', ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>', { noremap = true, silent = true })

-- quickfix
u.remap("n", "<Leader>qc", ":cclose<CR>", { noremap = true })
u.remap("n", "<Leader>qn", ":cnext<CR>", { noremap = true })
u.remap("n", "<Leader>qo", ":copen<CR>", { noremap = true })
u.remap("n", "<Leader>qp", ":cprev<CR>", { noremap = true })
u.remap("n", "<Leader>qa", ":cc<CR>", { noremap = true })

-- locationlist
u.remap("n", "<Leader>lc", ":lclose<CR>", { noremap = true })
u.remap("n", "<Leader>ln", ":lnext<CR>", { noremap = true })
u.remap("n", "<Leader>lo", ":lopen<CR>", { noremap = true })
u.remap("n", "<Leader>lp", ":lprev<CR>", { noremap = true })
u.remap("n", "<Leader>la", ":ll<CR>", { noremap = true })

-- fugitive
u.remap('n', '<leader>gs',  ':Git<CR>', {})
u.remap('n', '<leader>gc',  ':Git commit<CR>', {})
u.remap('n', '<leader>gpl', ':Git pull<CR>', {})
u.remap('n', '<leader>gl',  ':Git log<CR>', {})
u.remap('n', '<leader>gp',  ':Git push<CR>', {})
u.remap('n', '<leader>gb',  ':Git blame<CR>', {})
u.remap('n', '<leader>gd',  ':DiffviewOpen<CR>', {})
u.remap('n', '<leader>gq',  ':DiffviewClose<CR>', {})
u.remap('n', '<leader>gh',  ':DiffviewFileHistory<CR>', {})

-- config files
u.remap('n', '<leader>ev', ':vsplit ~/.config/nvim/init.lua<CR>', { noremap = true })
u.remap('n', '<leader>et', ':vsplit ~/.tmux.conf<CR>', { noremap = true })
u.remap('n', '<leader>ez', ':vsplit ~/.zshrc<CR>', { noremap = true })
u.remap('n', '<leader>ef', ':vsplit ~/.config/fish/config.fish<CR>', { noremap = true })
u.remap('n', '<leader>ek', ':vsplit ~/.config/Karabiner/karabiner.json<CR>', { noremap = true })

-- Trouble
u.remap("n", "<leader>xx", "<cmd>Trouble<cr>", { silent = true, noremap = true })
u.remap("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", { silent = true, noremap = true })
u.remap("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>", { silent = true, noremap = true })
u.remap("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { silent = true, noremap = true })
u.remap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })
u.remap("n", "gR", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })

-- telescope
u.remap("n", "<leader>ff",  telescope.find_files,       { noremap = true })
u.remap("n", "<C-p>",       telescope.live_grep,        { noremap = true })
u.remap("n", "<Leader>fd",  telescope.find_dotfiles,    { noremap = true })
u.remap("n", "<Leader>fh",  telescope.find_help,        { noremap = true })
u.remap("n", "<Leader>fm",  telescope.find_mappings,    { noremap = true })
u.remap("n", "<Leader>fc",  telescope.find_commands,    { noremap = true })
u.remap("n", "<Leader>fhi", telescope.find_highlights,  { noremap = true })
u.remap("n", "<Leader>fb",  telescope.find_buffers,     { noremap = true })
u.remap("n", "<Leader>fs",  telescope.current_buffer_fuzzy_find,    { noremap = true })
u.remap("n", "<Leader>fg",  telescope.git_branches,     { noremap = true })

-- lsp
u.remap('n', '<leader>cD', vim.lsp.buf.declaration,                 { silent = true })
u.remap('n', '<leader>cd', vim.lsp.buf.definition,                  { silent = true })
u.remap('n', '<leader>cR', vim.lsp.buf.references,                  { silent = true })
u.remap('n', 'K',          vim.lsp.buf.hover,                       { silent = true })
u.remap('n', '<leader>cn', vim.lsp.diagnostic.goto_next,            { silent = true })
u.remap('n', '<leader>cN', vim.lsp.diagnostic.goto_prev,            { silent = true })
u.remap('n', '<leader>cd', vim.lsp.diagnostic.get_line_diagnostics, { silent = true })
u.remap('n', '<leader>cf', vim.lsp.buf.formatting,                  { silent = true })
u.remap('n', '<leader>cr', vim.lsp.buf.rename,                      { silent = true })
u.remap('n', '<leader>ca', vim.lsp.buf.code_action,                 { silent = true })

-- term
u.remap("n", "<leader>tt", toggleterm.toggle_test_term, { noremap = true, silent = true })
u.remap("n", "<leader>tn", toggleterm.toggle_node_term, { noremap = true, silent = true })
u.remap("n", "<leader>th", toggleterm.toggle_cheat_term, { noremap = true, silent = true })
