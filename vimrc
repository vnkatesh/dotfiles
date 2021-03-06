set nocompatible
let mapleader=","
syntax enable

" Ledger
au BufNewFile,BufRead *.ldg,*.ledger setf ledger | comp ledger

" Pathogen
filetype off " Pathogen needs to run before plugin indent on
call pathogen#runtime_append_all_bundles()
call pathogen#helptags() " generate helptags for everything in 'runtimepath'
filetype plugin indent on

helptags ~/.vim/bundle/snipmate.vim/doc/
set bg=dark
nnoremap <leader>1 yypVr-
filetype off
filetype plugin indent on
set modelines=0
set tabstop=4
"http://unix.stackexchange.com/questions/71109/how-can-i-exit-from-read-only-mode-in-vim
set noro
set shiftwidth=4
set shiftround
set softtabstop=4
set expandtab
set encoding=utf-8
set scrolloff=3
set tabpagemax=100
set number
set autoindent
set copyindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set cursorline
set cursorcolumn
set ttyfast
set ruler
let g:load_doxygen_syntax=1
syntax on
set backspace=indent,eol,start
set laststatus=2
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set smarttab
set undolevels=1000
set wildignore=*.swp,*.bak,*.pyc,*.class,*.svn
set title
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %
set wrap
set textwidth=130
set formatoptions=qrn1
nnoremap j gj
nnoremap k gk
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
nnoremap ; :
au FocusLost * :wa
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
nnoremap <leader>a :Ack
nnoremap <leader>ft Vatzf
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>
nnoremap <leader>q gqip
nnoremap <leader>v V`]
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
inoremap jj <ESC>
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8 bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif

" modify selected text using combining diacritics
command! -range -nargs=0 Overline        call s:CombineSelection(<line1>, <line2>, '0305')
command! -range -nargs=0 Underline       call s:CombineSelection(<line1>, <line2>, '0332')
command! -range -nargs=0 DoubleUnderline call s:CombineSelection(<line1>, <line2>, '0333')
command! -range -nargs=0 Strikethrough   call s:CombineSelection(<line1>, <line2>, '0336')

function! s:CombineSelection(line1, line2, cp)
  execute 'let char = "\u'.a:cp.'"'
  execute a:line1.','.a:line2.'s/\%V[^[:cntrl:]]\%V/&'.char.'/ge'
endfunction

" omnicppcomplete options
map <C-x><C-x><C-T> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -f ~/.vim/commontags /usr/include /usr/local/include<CR><CR>
set tags+=~/.vim/commontags
 
" --- OmniCppComplete ---
" -- required --
set nocp " non vi compatible mode
filetype plugin on " enable plugins
 
" -- optional --
" auto close options when exiting insert mode or moving away
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
set completeopt=menu,menuone
 
" -- configs --
let OmniCpp_MayCompleteDot = 1 " autocomplete with .
let OmniCpp_MayCompleteArrow = 1 " autocomplete with ->
let OmniCpp_MayCompleteScope = 1 " autocomplete with ::
let OmniCpp_SelectFirstItem = 2 " select first item (but don't insert)
let OmniCpp_NamespaceSearch = 2 " search namespaces in this and included files
let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype (i.e. parameters) in popup window
let OmniCpp_LocalSearchDecl = 1 " don't require special style of function opening braces
 
" -- ctags --
" map <ctrl>+F12 to generate ctags for current folder:
map <C-x><C-t> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>
" add current directory's generated tags file to available tags
set tags+=./tags
 
" Setup the tab key to do autocompletion
function! CompleteTab()
  let prec = strpart( getline('.'), 0, col('.')-1 )
  if prec =~ '^\s*$' || prec =~ '\s$'
    return "\<tab>"
  else
    return "\<c-x>\<c-o>"
endif
endfunction

autocmd FileType c inoremap <tab> <c-r>=CompleteTab()<cr>
autocmd FileType cpp inoremap <tab> <c-r>=CompleteTab()<cr>
nmap <leader>ev :e $MYVIMRC<CR>
nmap <leader>sv :so $MYVIMRC<CR>
set nowrap
set pastetoggle=<F2>
cmap w!! w !sudo tee % >/dev/null
nmap <silent> ,/ :nohlsearch<CR>
inoremap <C-@> <C-P>

" mac os x crontab edit.
set backupskip=/tmp/*,/private/tmp/*" 

"http://syskall.com/my-biggest-vim-productivity-boost/
"map <C-J> :bnext<CR>
"map <C-K> :bprev<CR>
map <C-L> :tabn<CR>
map <C-H> :tabp<CR>

"http://stackoverflow.com/questions/2019281/load-different-colorscheme-when-using-vimdiff
if &diff
        colorscheme solarized
endif
