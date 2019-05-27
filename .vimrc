"     _   ___ __       _          _    ___
"    / | / (_) /_____ ( )_____   | |  / (_)___ ___  __________
"   /  |/ / / __/ __ \|// ___/   | | / / / __ `__ \/ ___/ ___/
"  / /|  / / /_/ /_/ / (__  )    | |/ / / / / / / / /  / /__
" /_/ |_/_/\__/\____/ /____/     |___/_/_/ /_/ /_/_/   \___/

" Init vim-plug pluggin manager
" :PlugInstall (Install semua plugin yang disebutkan dibawah)
" :PlugClean (Uninnstall semua plugin yang dihapus dari bawah)
call plug#begin('~/.vim/vim-plug-pluggins')

" Nerd Tree (File Explorer)
Plug 'scrooloose/nerdtree', { 'on':  ['NERDTreeToggle', 'NERDTreeTabsToggle'] }   
Plug 'jistr/vim-nerdtree-tabs', { 'on':  'NERDTreeTabsToggle' }

" Git
Plug 'airblade/vim-gitgutter' " untuk melihat baris yang diubah (changes git) seperti di IDE
Plug 'tpope/vim-fugitive' " Git commands in vim (commit, push, status, blame, etc)
Plug 'tpope/vim-rhubarb' " :Gbrowse dari vim-fugitive ke github
Plug 'Xuyuanp/nerdtree-git-plugin' " Integrasi git dengan Nerd Tree

" Syntax & Code Check
Plug 'sheerun/vim-polyglot' " Language pack for syntax checking
Plug 'neomake/neomake' " Error checking (harus install runner/maker yang sesuai dengan filetype yg digunakan)

" Useful / Essential
Plug 'jiangmiao/auto-pairs' 
Plug 'simeji/winresizer' " Easy resize split windows dengan resize mode seperti di i3
Plug 'tpope/vim-commentary' " Comment baris dengan 'gcc' atau gc<motion> (ex: gcap, 2gcj)
Plug 'tpope/vim-surround' " manipulasi text dengan kurung (){}[]''<>
Plug 'ervandew/supertab' " auto completion with <TAB> in insert mode
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Remove this if already install fzf
Plug 'junegunn/fzf.vim'
Plug 'moll/vim-bbye' " Hapus buffer tanpa menhilangkan window/layout

" Colors & Looks
Plug 'itchyny/lightline.vim' " bar dibawah
Plug 'mengelbrecht/lightline-bufferline' " bar buffer di atas pengganti bar tab
Plug 'ayu-theme/ayu-vim' " Color theme ayu pada vim
Plug 'drewtempelmeyer/palenight.vim' " Color theme palenight
Plug 'morhetz/gruvbox' 
Plug 'mhinz/vim-startify' " Start menu saat buka vim tanpa argument
Plug 'ryanoasis/vim-devicons'

call plug#end()

" # Color and bling
set termguicolors  " Enable color in gui vim 
set t_Co=256 " Enable 256 True color in terminal vim
set laststatus=2 " for vim lightline
set showtabline=2  " Show tabline for lightline bufferline
set noshowmode " Menghilangkan tulisan --INSERT-- default karena sudah ada lightline
set cmdheight=1

" " Ayu colorscheme
" let ayucolor="dark"  " dark/mirage/light
" colorscheme ayu

" " palenight colorscheme
" set background=dark
" colorscheme palenight
" let g:palenight_terminal_italics=1

" " gruvbox dark colorscheme
set bg=dark
let g:gruvbox_bold = 1
let g:gruvbox_italic = 1
let g:gruvbox_underline = 1
let g:gruvbox_undercurl = 1
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox

" Map leader to space/spasi"
let mapleader = " "

" # General
set encoding=UTF-8
set hidden " Pindah ke buffer lain tanpa perlu save
set number "Membuat baris nomor di sebelah kiri seperti IDE
set relativenumber "Membuat baris nomor relatif dari baris cursor
set cursorline " Highlight baris cursor berada
set nowrap " Agar text panjang tidak terpotong ke baris selanjutnya (untuk coding)
syntax on "Memastikan syntax untuk color theme selalu nyala
"set lazyredraw

set backup 
set undodir=~/.vim/undodir " Persistent undo (bisa undo walaupun vim sudah di close)
set wildmenu " turn on command line completion wild style
set wildmode=list,full " tab completion di command mode sama seperti di terminal

" # Finding text (/ | ?)
set incsearch "Highlight text while search
set ignorecase 
set completeopt=longest,menuone " better autocompletion
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>" |" <Enter> to chose auto completion

" arrow keys disable & UP/DOWN in Command mode
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
cnoremap <C-k> <UP>
cnoremap <C-j> <Down>

" Fast escape (no delay)
set noesckeys  " insert mode
vnoremap <Esc> <C-c> | " Visual mode
cnoremap <Esc> <C-c> | " Command mode

" x permanent delete
nnoremap x "_x
vnoremap x "_x
nnoremap X "_X
vnoremap X "_X

" Insert and delete line above & below cursor
nnoremap <silent>]O m`:silent +g/\m^\s*$/d<CR>``:noh<CR> |" delete below cursor
nnoremap <silent>[O m`:silent -g/\m^\s*$/d<CR>``:noh<CR> |" delete above cursor
nnoremap <silent>]o :set paste<CR>m`o<Esc>``:set nopaste<CR> |" insert below cursor
nnoremap <silent>[o :set paste<CR>m`O<Esc>``:set nopaste<CR> |" insert above cursor

" # Clipboard (primary) & Saving
set clipboard=unnamed " Mengubah register default vim (saat p) menjadi dari primary register
noremap <C-c> "+
inoremap <C-v> <C-r>+
noremap <C-s> :update<CR>
vnoremap <C-s> <Esc>:update<CR>
inoremap <C-s> <Esc>:update<CR>

" # Splits
" normal mode & insert mode map untuk pindah fokus window/split:
" - :vsplit -> Ctrl+w+v
" - Ctrl+w+h -> Ctrl+h
" - Ctrl+w+j -> Ctrl+j
" - Ctrl+w+k -> Ctrl+k
" - Ctrl+w+l -> Ctrl+l
noremap <C-k> <C-w>k
noremap <C-j> <C-w>j
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l
set splitbelow "split dari :sp muncul di bawah
set splitright "split dari :vsp muncul di kanan

" # Tabs
" map <NUMBER> +leaderuntuk pindah tab sesuai nomornya
noremap <silent> 1<leader> 1gt
noremap <silent> 2<leader> 2gt
noremap <silent> 3<leader> 3gt
noremap <silent> 4<leader> 4gt
noremap <silent> 5<leader> 5gt
noremap <silent> 6<leader> 6gt
noremap <silent> 7<leader> 7gt
noremap <silent> 8<leader> 8gt
noremap <silent> 9<leader> 9gt
noremap <silent> <leader>0 :call NerdTreeSync(":tablast")<cr>
noremap <silent> <leader>n :call NerdTreeSync(":tabnext")<cr>
noremap <silent> <leader>p :call NerdTreeSync(":tabprev")<cr>
noremap <silent> <leader>t :tabs<cr>

" leader+a pindah ke recent tab (tab terakhir) pada normal mode & visual mode
au TabLeave * let g:lasttab = tabpagenr()
noremap <silent> <leader>a :exe "tabn ".g:lasttab<cr>

" # Buffers
map  [; <C-Semicolon>
map! [; <C-Semicolon>
noremap <silent> ;n :call NerdTreeSync(":bn")<cr>
noremap <silent> ;p :call NerdTreeSync(":bp")<cr>
noremap <silent> ;d :Bdelete<cr>
noremap <silent> ;# :call NerdTreeSync(":b#")<cr>
nmap <silent> 1; :b1<cr>
nmap <silent> 2; :b2<cr>
nmap <silent> 3; :b3<cr>
nmap <silent> 4; :b4<cr>
nmap <silent> 5; :b5<cr>
nmap <silent> 6; :b6<cr>
nmap <silent> 7; :b7<cr>
nmap <silent> 8; :b8<cr>
nmap <silent> 9; :b9<cr>
nmap <silent> 0; :b10<cr>

" # Functions & Scripts
" open plugins cheatsheet (invoke with :call Ch())
function! Ch()
    :sp ~/cheatsheet-vim-pluggins
endfunction

" menjalankan "xrdb .Xresources" setiap kali .Xresource/.Xdefaults di save 
autocmd BufWritePost ~/.Xresources,~/.Xdefaults !xrdb %

" # Plugins
" autocompletion tab pilih opsi pertama
let g:SuperTabLongestHighlight = 1
let g:SuperTabMappingBackward = '<c-j>'
" let g:SuperTabMappingForward = '<c-space>'

set updatetime=300 " Update time untuk git gutter plugin
" Lompat ke perubahan berikutnya di git dengan [h / ]h
" Preview git diff perubahan dengan <leader>hp
" Undo perubahan git dengan <leader>hu
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk
autocmd BufWritePost * GitGutter " Update changes git saat save
" fugitive-vim git keymaps
noremap <silent> <leader>gb :Gblame<cr>
noremap <silent> <leader>gs :Gstatus<cr>
noremap <silent> <leader>gd :Gdiff<cr>
noremap <silent> <leader>gc :Gcommit<cr>
noremap <silent> <leader>gp :Gpush<cr>
" from fzf.vim
noremap <silent> <leader>gl :Commits<cr>
noremap <silent> <leader>g;l :BCommits<cr>

let g:lightline = {
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename'] ]
            \ },
            \ 'component_function': {
            \   'filename': 'LightlineFullFilename_MergeModified',
            \   'gitbranch': 'LightlineGitBranch',
            \   'fileformat': 'LightlineFileformat',
            \   'filetype': 'LightlineFiletype',
            \   'fileencoding': 'LightlineFileencoding',
            \   'tabinfo': 'TabStatusInfo'
            \ },
            \ }

let g:lightline.colorscheme = 'gruvbox'
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['tabinfo']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#show_number = 1
let g:lightline#bufferline#modified = ' ' 

let g:lightline.separator = {
\   'left': '', 'right': ''
\}
let g:lightline.subseparator = {
\   'left': '', 'right': ''
\}

let g:lightline#bufferline#enable_devicons = 1

" Show full path of filename & chane 'modified'
function! LightlineFullFilename_MergeModified()
    if winwidth(0) >= 80
        let filename = expand('%') !=# '' ? expand('%') : '[No Name]'
        let modified = &modified ? ' ' : ''
    else
        let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
        let modified = &modified ? ' ' : ''
    endif
    return filename . modified
endfunction

" Hilangkan file format saat window mengecil
function! LightlineFileformat()
  return winwidth(0) > 115 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

" Hilangkan file type saat window mengecil
function! LightlineFiletype()
  return winwidth(0) > 115 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

" Hilangkan file encoding saat window mengecil
function! LightlineFileencoding()
  return winwidth(0) > 115 ? &fileencoding : ''
endfunction

" Hilangkan nama branch saat window mengecil
function! LightlineGitBranch()
  let symbol = ' '
  let branch = fugitive#head() !=# '' ? symbol . fugitive#head() : ''
  return winwidth(0) > 107 ? branch : ''
endfunction

" Informasi tab ke berapa dan berapa jumlah total tab
function! TabStatusInfo()
    return ' Tabs: ' . tabpagenr() . '/' . tabpagenr('$')
endfunction

" map leader+n toggle NERDTree on/off
"noremap <leader>t :NERDTreeToggle<CR>
noremap <silent> <leader>e :call NerdTreeSync(":NERDTreeToggle")<cr>
noremap <silent> <leader>E :call NerdTreeSync(":NERDTreeTabsToggle")<cr>
silent! map <F2> :NERDTreeFind<CR>

let g:nerdtree_tabs_open_on_console_startup=2
let g:nerdtree_tabs_open_on_gui_startup=2

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "",
    \ "Staged"    : "",
    \ "Untracked" : "",
    \ "Renamed"   : "",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "",
    \ "Dirty"     : "",
    \ "Clean"     : "",
    \ 'Ignored'   : '',
    \ "Unknown"   : "?"
    \ }

" Masuk resize mode untuk split window dengan Ctrl+wr
let g:winresizer_start_key = '<C-w>r'
let g:winresizer_finish_with_escape = 1

" Nerd Tree pake icon folder dari NerdFonts
" let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:nerdtree_tabs_startup_cd = 1  
let NERDTreeMinimalUI = 1
let NERDTreeChDirMode = 2

" Nerd Tree auto-sync directory with open file
function! NerdTreeSync(tab)
    if a:tab == ":NERDTreeTabsToggle" || a:tab == ":NERDTreeToggle"
        if exists("g:NERDTree") && g:NERDTree.IsOpen()
            execute a:tab
        else
            execute a:tab
            wincmd l
            NERDTreeFind
            wincmd l
        endif
    else 
        if exists("g:NERDTree") && g:NERDTree.IsOpen()
            execute a:tab
            if exists("g:NERDTree") && g:NERDTree.IsOpen()
            NERDTreeFind
            wincmd l
            endif
        else
            execute a:tab
        endif
    endif
endfunction

" Neomake code linting no delay
call neomake#configure#automake('nrwi', 500)

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" let g:fzf_buffers_jump = 1

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
" fzf mapping (<C-_> = Ctrl /)
noremap <silent> <C-p> :Files<cr>
noremap <silent> <leader><C-p> :Files <C-r>=expand("%:h")<CR>/<CR>
noremap <silent> <C-_> :Rg<cr>
noremap <silent> <C-Semicolon> :Buffers<cr>
noremap <silent> ;l :BLines<cr>
noremap <silent> ;] :BTags<cr>
noremap <silent> <leader>l :Lines<cr>
noremap <silent> <leader>] :Tags<cr>

" fzf set warna sesuai colorscheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Git log format
let g:fzf_commits_log_options = '--graph --color=always --format="%C(bold blue)<%an>%Creset%Creset%C(yellow)%d%Creset %s %Cgreen(%cr) %Cred-%h-%Creset" --abbrev-commit'

" Bookmark buat plugin vim-startify
let g:startify_bookmarks = [ {'v': '~/.vimrc'}, {'x': '~/.Xresources'}]
let g:startify_change_to_dir = 1 " Ganti ke directory setiap buka file dengan startify
" Tutup Nerd Tree saat save session dengan startify
let g:startify_session_before_save = [ 
    \ 'echo "Cleaning up before saving.."',
    \ 'silent! NERDTreeTabsClose',
    \'',
    \ ]
" Urutan menu yang muncul di startify
let g:startify_lists = [
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'files',     'header': ['   Recent Files']   },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]

" Custom header startify
function! s:filter_header(lines) abort
    let longest_line   = max(map(copy(a:lines), 'strwidth(v:val)'))
    let centered_lines = map(copy(a:lines),
        \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
    return centered_lines
endfunction

let g:startify_custom_header = s:filter_header([
\' _    ________  ___            _    ___ ',
\'| |  / /  _/  |/  /           | |  / (_)',
\'| | / // // /|_/ /  ______    | | / / / ',
\'| |/ // // /  / /  /_____/    | |/ / /  ',
\'|___/___/_/  /_/              |___/_/   ',
\'                                        ',
\'    ______  ___                               __',
\'   /  _/  |/  /___  _________ _   _____  ____/ /',
\'   / // /|_/ / __ \/ ___/ __ \ | / / _ \/ __  / ',
\' _/ // /  / / /_/ / /  / /_/ / |/ /  __/ /_/ /  ',
\'/___/_/  /_/ .___/_/   \____/|___/\___/\__,_/   ',
\'          /_/',
\'',
\'      Best Text Editor in the world',
\'',
\])
