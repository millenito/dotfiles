"  _   _ _ _        _                 _       _                 _
" | \ | (_) |_ ___ ( )___   _ __ ___ (_)_ __ (_)_ __ ___   __ _| |
" |  \| | | __/ _ \|// __| | '_ ` _ \| | '_ \| | '_ ` _ \ / _` | |
" | |\  | | || (_) | \__ \ | | | | | | | | | | | | | | | | (_| | |
" |_| \_|_|\__\___/  |___/ |_| |_| |_|_|_| |_|_|_| |_| |_|\__,_|_|
"
"          __   _(_)_ __ ___  _ __ ___
"          \ \ / / | '_ ` _ \| '__/ __|
"           \ V /| | | | | | | | | (__
"            \_/ |_|_| |_| |_|_|  \___|
"
set nocompatible                                                   " Dont be compatible with old 'vi'

filetype plugin indent on                                          " Load plugins according to detected filetype.
syntax on                                                          " Enable syntax highlighting.
set title                                                          " Proper window title
set encoding=utf8                                                  " Enable utf8 support
set mouse=a                                                        " Enable mouse support
set visualbell t_vb=" "                                            " No visual bell

set autoindent                                                     " Indent according to previous line.
set expandtab                                                      " Use spaces instead of tabs.
set softtabstop =4                                                 " Tab key indents by 4 spaces.
set shiftwidth  =4                                                 " >> indents by 4 spaces.
set shiftround                                                     " >> indents to next multiple of 'shiftwidth'.

set autoread                                                       " reload on external file changes
set backspace   =indent,eol,start                                  " Make backspace work as you would expect.
set hidden                                                         " Switch between buffers without having to save first.
set display     =lastline                                          " Show as much as possible of the last line.

set incsearch                                                      " Highlight while searching with / or ?.
set hlsearch                                                       " Keep matches highlighted.
set ignorecase smartcase                                           " ignore case when searching except when text have capital
set wrapscan                                                       " Searches wrap around end-of-file.

set nowrap                                                         " Dont wrap text
set number                                                         " Show Line numbers
set relativenumber                                                 " Combine line numbers and relativenumber
set ruler                                                          " Always show cursor position
set cursorline                                                     " Highlight current line at cursor
set showcmd                                                        " Show already typed keys when more are expected.

set ttyfast                                                        " Faster redrawing.
set lazyredraw                                                     " Only redraw when necessary.

set splitbelow                                                     " Open new windows below the current window.
set splitright                                                     " Open new windows right of the current window.

set wildmenu                                                       " Turn on command line completions
set wildmode=longest:full,full
set wildignorecase                                                 " Ignore case on completion
set wildignore+=*/.git/**/*,*/.hg/**/*,*/.svn/**/*,*/compiled/**/* " Ignored folders in autocomplete
set clipboard=unnamed,unnamedplus                                  " Main clipboard uses system clipboard

set foldmethod=syntax                                              " Fold by indents
set foldlevelstart=999                                             " Start file with all folds opened

set path+=**                                                       " Find files recursively from current working directory
" Find files using ripgrep if exist (https://github.com/BurntSushi/ripgrep)
if executable('rg')
    set grepprg=rg\ --column\ --line-number\ --no-heading\ --color=always\ --smart-case
endif

" Map <Leader> to space
let mapleader = " "

" <Esc> remove search highlighting
noremap <silent> <esc> :nohl<CR>

" Fast escape (no delay)
vnoremap <Esc> <C-c>
cnoremap <Esc> <C-c>

" Y works like D and C
noremap Y y$

" Toggle paste mode
set pastetoggle=<F2>

" Ctrl+v paste from main register in insert and command mode
inoremap <C-v> <C-r>+
cnoremap <C-v> <C-r>+

" Move between splits with Ctrl+h/j/k/l
noremap <C-k> <C-w>k
noremap <C-j> <C-w>j
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l

" Insert new line above/below cursor
nnoremap <silent> ]<cr> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent> [<cr> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" Delete new line above/below cursor
nnoremap <silent> ]d m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent> [d m`:silent -g/\m^\s*$/d<CR>``:noh<CR>

" List & choose buffers
noremap 'w :ls<CR>:b<Space>
noremap 's :ls<CR>:sb<Space>
noremap 'v :ls<CR>:vertical sb<Space>

" Find files
nnoremap <leader>fw :find *
nnoremap <leader>fs :sfind *
nnoremap <leader>fv :vert sfind *
nnoremap <leader>ft :tabfind *

" GNU Readline mappings in command mode
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap  <C-B> <Left>
cnoremap  <C-F> <Right>
cnoremap  <M-f> <S-Right>
cnoremap  <M-b> <S-Left>
cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"

cnoremap  <C-Y> <C-R>-
cnoremap  <M-d> <S-Right><C-W>
cnoremap  <M-BS> <C-W>
cnoremap  <C-n> <Down>
cnoremap  <C-p> <Up>

" Autocomplete parenthesis, brackets and braces
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>

" Autocomplete quotes
inoremap	'  '<Esc>:call QuoteInsertionWrapper("'")<CR>a
inoremap	"  "<Esc>:call QuoteInsertionWrapper('"')<CR>a
inoremap	`  `<Esc>:call QuoteInsertionWrapper('`')<CR>a

" hide banner and '.' in netrw
let g:netrw_banner = 0
let g:netrw_list_hide = '^\./$'
let g:netrw_hide = 1

" open netrw like nerdtree in tree mode
noremap <silent> <leader>e :call NetrwNerdtree()<cr>

" open netrw on current pane or split, vsplit and tab
noremap <silent> <leader>w :call NetrwOpen("window")<cr>
noremap <silent> <leader>s :call NetrwOpen("split")<cr>
noremap <silent> <leader>v :call NetrwOpen("vsplit")<cr>
noremap <silent> <leader>t :call NetrwOpen("tab")<cr>

function! QuoteInsertionWrapper (quote)
    let col = col('.')
    if getline('.')[col-2] !~ '\k' && getline('.')[col] !~ '\k'
        normal ax
        exe "normal r".a:quote."h"
    end
endfunction

function! NetrwNerdtree()
    let g:netrw_liststyle=3

    execute "Vexplore "
    wincmd H

    execute "vertical resize 45"
endf

function! NetrwOpen(pane)
    let g:netrw_liststyle=0

    if a:pane == "split"
        execute "Hexplore "
    elseif a:pane == "vsplit"
        execute "Vexplore! "
    elseif a:pane == "tab"
        execute "Texplore "
    else
        execute "Explore "
    endif
endfunction
