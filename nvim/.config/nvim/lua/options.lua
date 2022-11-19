local o = vim.o

o.termguicolors  = true
o.autoread       = true
o.backspace      = "2"
o.clipboard      = "unnamed"
o.cursorline     = true
o.expandtab      = true
o.history        = 100
o.incsearch      = true
o.mouse          = "a"
o.errorbells     = false
o.swapfile       = false
o.visualbell     = false
o.wrap           = false
o.number         = true
o.relativenumber = true
o.scroll         = 10
o.shiftround     = true
o.shiftwidth     = 2
o.showmatch      = true
o.signcolumn     = "yes"
o.smartcase      = true
o.smartindent    = true
o.scrolloff      = 10
o.splitbelow     = true
o.splitright     = true
o.tabstop        = 2
o.timeoutlen     = 1000
o.ttimeoutlen    = 50
o.wildignore     = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**"
o.grepprg        = "rg --vimgrep --no-heading --smart-case"
o.grepformat     = "%f:%l:%c:%m"
o.shell          = "/bin/bash"
o.completeopt    = "menuone,noselect"
o.pumheight      = 10
o.pumblend       = 0
o.undofile       = true
o.laststatus     = 3
