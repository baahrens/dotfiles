"----------------------------
" Call pathogen
execute pathogen#infect()

set nocompatible
set history=100
set clipboard^=unnamed
set encoding=utf-8
" set ruler
set smartcase
set showmatch
set autoread
set noerrorbells
set novisualbell
set noswapfile
"
" performance
set lazyredraw
set ttyfast

let mapleader = ','
let g:mapleader = ','

" ---------------------------
" gui stuff
syntax on
filetype plugin indent on
syntax enable

set nowrap
set smartindent
set expandtab
set tabstop=2
set shiftround
set shiftwidth=2
set backspace=2
set cursorline
set incsearch
set hlsearch
set relativenumber
set splitbelow splitright

" Colorscheme
set t_Co=256
colorscheme gruvbox
set background=dark

" Filetypes
autocmd BufWritePost .vimrc source $MYVIMRC
autocmd BufNewFile,BufRead .babelrc set filetype=json
autocmd BufNewFile,BufRead .eslintrc set filetype=json
autocmd BufNewFile,BufRead .tern-project set filetype=json

" ---------------------------
" Mappings

vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

map <space> /
map <c-space> ?

" conf files
nnoremap <leader>ev :vsplit ~/.vimrc<cr>
nnoremap <leader>et :vsplit ~/.tmux.conf<cr>

" center searchresults
nnoremap n nzzzv
nnoremap N Nzzzv

" reindent file
nnoremap <leader>m G=gg''

" shift left/right for going to start/end of line
noremap H ^
noremap L $

" vselect between brackets
noremap % v%

imap ii <Esc>
imap jk <Esc>

" center after scrolling
nmap G Gzz

function! Semicolon()
  :execute "normal! mqA;\<esc>`q"
endfunction
nnoremap <Leader>s :call Semicolon()<CR>


" disable other arrow keys
no <left> <Nop>
no <right> <Nop>
ino <up> <Nop>
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
vno <up> <Nop>
vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>

" Toggle relative numbers
nnoremap <F12> :call ToggleRelativeAbsoluteNumber()<CR>
function! ToggleRelativeAbsoluteNumber()
  if &number==1
    set relativenumber
  else
    set norelativenumber
    set number
  endif
endfunction

" Copypasting settings
set pastetoggle=<F2>
map <silent><Leader>p :set paste<CR>o<esc>
map <silent><Leader><S-p> :set paste<CR>0<esc>


" ----------------------------
" PLUGIN SETTINGS

" YouCompleteMe settings
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_log_level = 'warning'
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']

" jsdoc settings
let g:jsdoc_underscore_privat = 1
let g:jsdoc_enable_es6 = 1
let g:jsdoc_access_descriptions = 1
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_param_description_seperator = ','

" ----------------------------
"  startify settings
let g:startify_change_to_vcs_root = 1

" ----------------------------
" Nerdtree settings
map <Leader>nn :NERDTreeToggle<CR>
map <Leader>nf :NERDTreeFind<CR>
let NERDTreeMinimalUI = 1
let NERDTreeShowFiles = 1
let NERDTreeMouseMode = 2
let NERDTreeShowHidden = 1
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('md', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')

" ----------------------------
" UltiSnips
let g:UltiSnipsExpandTrigger = '<C-x>'
let g:UltiSnipsJumpForwardTrigger="<C-v>"
let g:UltiSnipsJumpBackwardTrigger="<C-b>"

" ----------------------------
" CtrlP settings
nnoremap <C-P> :CtrlPMRU<CR>
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:ctrlp_window = 'top,order:btt,min:1,max:10,results:10'
let g:ctrlp_open_new_file = 'v'
let g:ctrlp_use_caching = 1
let g:ctrlp_custom_ignore = '\v[\/](node_modules|.git|.meteor)|(\.(swp|swo|git))$'

" ----------------------------
" tmuxline settings
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W', '#F'],
      \'y'    : ['%R', '%a', '%Y'],
      \'z'    : '#H'}

" ----------------------------
" airline settings
set laststatus=2

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let airline#extensions#tmuxline#snapshot_file = "~/tmuxline.conf"
let g:airline#extensions#tmuxline#enable = 1
let g:airline#extensions#ycm#enabled = 1

let g:airline_theme = 'wombat'
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#format = 2
let g:airline_symbols.space = "\ua0"

" enable jsx in non .jsx files
let g:jsx_ext_required = 0
