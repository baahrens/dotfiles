" set python path
" dont allow python2
let g:loaded_python_provider = 1
" skip all checks
let g:python3_host_skip_check = 1
" fzf rtp
set rtp+=/usr/local/opt/fzf

"----------------------------
" Call pathogen
execute pathogen#infect()

" don't resize other panes when closing one
" set noea
" fixed height
set winfixheight

set history=100
set clipboard^=unnamed
set autoread
set noerrorbells
set novisualbell
set noswapfile

"scroll 10 lines before bottom
set so=10

" movement mappings for all windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" Maps Alt-[s.v] to horizontal and vertical split respectively
map <silent> ‚ :split<CR>
map <silent> √ :vsplit<CR>

" Maps Alt-[n,p] for moving next and previous window respectively
map <silent> ~ <C-w><C-w>
map <silent> π <C-w><S-w>

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

" performance
set lazyredraw
set ttyfast

set incsearch
set hlsearch
set smartcase
set showmatch
set relativenumber
set splitbelow splitright

" Colorscheme
set t_Co=256
colorscheme gruvbox
" set termguicolors
" let ayucolor="dark"
" colorscheme ayu
set background=dark
" hi link xmlEndTag xmlTag
" hi Tag        ctermfg=04
" hi xmlTag     ctermfg=04
" hi xmlTagName ctermfg=04
" hi xmlEndTag  ctermfg=04

" center buffer around cursor
autocmd BufRead * normal zz
" Filetypes
autocmd BufWritePost .vimrc source $MYVIMRC
autocmd BufNewFile,BufRead .babelrc,.eslintrc,.tern-project set filetype=json

" ---------------------------
" Mappings

" replace word
nnoremap S diw"0P

vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

map <space> /
map <c-space> ?

" conf files
nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim<CR>
nnoremap <leader>gs :Gstatus<CR>

" center searchresults
nnoremap n nzzzv
nnoremap N Nzzzv
" center after scrolling
nmap G Gzz

" reindent file
nnoremap <leader>m G=gg''

" shift left/right for going to start/end of line
noremap H ^
noremap L $

" escape all the modes
inoremap jk <Esc>
xnoremap jk <Esc>  
cnoremap jk <Esc>  

" vselect between brackets
noremap % v%

function! Semicolon()
  :execute "normal! mqA;\<esc>`q"
endfunction
nnoremap <Leader>s :call Semicolon()<CR>

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

" ----------------------------
" PLUGIN SETTINGS

" ----------------------------

" tern settings
let g:tern_show_argument_hints = 'on_hold'
let g:tern_show_signature_in_pum = 1
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = '0'
let g:tern#filetypes = ['javascript', 'jsx', 'javascript.jsx']

autocmd FileType javascript,javascript.jsx,jsx setlocal omnifunc=tern#Complete

" deoplete settings
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#auto_complete_delay = 0
inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-l> deoplete#refresh()
inoremap <expr><Tab> pumvisible() ? "\<c-n>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<c-p>" : "\<S-Tab>"

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <silent><expr> <C-Space> deoplete#mappings#manual_complete()

" this removes the annoying buffer when suggesting things
set completeopt-=preview

" ----------------------------
"  startify settings
let g:startify_change_to_vcs_root = 1
let g:startify_custom_indices = map(range(1,100), 'string(v:val)')
let g:startify_session_sort = 1
let g:startify_session_number = 15
let g:startify_bookmarks = [ '~/.config/nvim/init.vim', '~/.tern-project', '~/.bash_profile']
let g:startify_list_order = ['bookmarks', 'files', 'dir', 'sessions']

highlight StartifyBracket ctermfg=240
highlight StartifyFooter  ctermfg=240
highlight StartifyHeader  ctermfg=240
highlight StartifyNumber  ctermfg=160
highlight StartifyPath    ctermfg=243
highlight StartifyFile    ctermfg=214
highlight StartifySlash   ctermfg=240
highlight StartifySection ctermfg=220

" ----------------------------
" Nerdtree settings
map <Leader>nn :NERDTreeToggle<CR>
map <Leader>nf :NERDTreeFind<CR>

let NERDTreeMinimalUI = 1
let NERDTreeShowFiles = 1
let NERDTreeMouseMode = 2
let NERDTreeShowHidden = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeAutoCenter = 1

let g:NERDTreeFileExtensionHighlightFullName = 1

" performance boost while scrolling
let g:NERDTreeDisableExactMatchHighlight = 1
let g:NERDTreeDisablePatternMatchHighlight = 1

let g:NERDTreeSyntaxDisableDefaultExtensions = 1
let g:NERDTreeSyntaxEnabledExtensions = ['scss', 'html', 'vim', 'jsx', 'json', 'rb', 'js', 'css']

" ----------------------------
" UltiSnips
let g:UltiSnipsExpandTrigger = '<C-x>'
let g:UltiSnipsListSnippets = '<C-tab>'
let g:UltiSnipsJumpForwardTrigger="<C-x>"
let g:UltiSnipsJumpBackwardTrigger="<C-b>"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/bundle/custom-snippets']

" ----------------------------
" airline settings
set laststatus=2

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_theme = 'gruvbox'
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#format = 2
let g:airline_symbols.space = "\ua0"
let g:airline_highlighting_cache=1

" ----------------------------
"  gitgutter settings
" let g:gitgutter_realtime = 0
" let g:gitgutter_eager = 0

let g:vim_jsx_pretty_colorful_config = 1
" ----------------------------
"  neomake settings
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_javascript_eslint_exe = $PWD . '/node_modules/.bin/eslint'
autocmd BufWritePost * Neomake

" ----------------------------
"  fzf settings
nnoremap <C-p> :GFiles<CR>
nnoremap <C-s> :Ag<CR>

" ----------------------------
" "  flow settings
" let g:flow#autoclose = 1
" " https://github.com/flowtype/vim-flow/issues/24
" let local_flow = finddir('node_modules', '.;') . '/.bin/flow'
" if matchstr(local_flow, "^\/\\w") == ''
"     let local_flow= getcwd() . "/" . local_flow
" endif
" if executable(local_flow)
"   let g:flow#flowpath = local_flow
" endif

let g:javascript_plugin_flow = 1

" " vim-move settings

" let g:move_key_modifier = 'C'

" ----------------------------
" fugitive settings
map <Leader>gp :Gpull<CR>
map <Leader>gs :Gstatus<CR>
map <Leader>gc :Gcommit<CR>
