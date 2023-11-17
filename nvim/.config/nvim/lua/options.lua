local options = vim.o
local opt = vim.opt
local global = vim.g

options.termguicolors = true
options.clipboard = "unnamedplus"
options.cursorline = true
options.expandtab = true
options.history = 100
options.incsearch = true
options.mouse = "a"
options.swapfile = false
options.wrap = false
options.number = true
options.relativenumber = true
options.scroll = 10
options.scrolloff = 10
options.shiftround = true
options.shiftwidth = 2
options.showmatch = true
options.signcolumn = "yes"
options.smartcase = true
options.smartindent = true
options.splitbelow = true
options.splitright = true
options.timeoutlen = 300
options.wildignore =
".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**"
options.grepprg = "rg --vimgrep --no-heading --smart-case"
options.grepformat = "%f:%l:%c:%m"
options.shell = "/bin/bash"
options.completeopt = "menuone,noselect,noinsert"
options.pumheight = 10
options.pumblend = 0
options.undofile = true
options.laststatus = 3

opt.fillchars:append({ diff = "╱" })

global.is_work_machine = vim.loop.os_gethostname() == "work"
global.is_macos = vim.loop.os_uname().sysname == "Darwin"

global.dotfiles_dir = vim.fn.expand("~") .. "/.dotfiles"
global.notes_dir = vim.fn.expand("~") .. "/notes"
global.template_dir = vim.g.dotfiles_dir .. "/nvim/.config/nvim/templates"
