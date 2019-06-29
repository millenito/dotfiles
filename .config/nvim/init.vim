"     _   ___ __       _          _       _ __        _         
"    / | / (_) /_____ ( )_____   (_)___  (_) /__   __(_)___ ___ 
"   /  |/ / / __/ __ \|// ___/  / / __ \/ / __/ | / / / __ `__ \
"  / /|  / / /_/ /_/ / (__  )  / / / / / / /__| |/ / / / / / / /
" /_/ |_/_/\__/\____/ /____/  /_/_/ /_/_/\__(_)___/_/_/ /_/ /_/ 

" Init vim-plug pluggin manager
" :PlugInstall (Install semua plugin yang disebutkan dibawah)
" :PlugClean (Uninnstall semua plugin yang dihapus dari bawah)
call plug#begin('~/.config/nvim/vim-plug-pluggins')

" File Explorer
Plug 'scrooloose/nerdtree', { 'on':  ['NERDTreeToggle', 'NERDTreeTabsToggle'] }   
Plug 'jistr/vim-nerdtree-tabs', { 'on':  'NERDTreeTabsToggle' }
Plug 'mcchrish/nnn.vim', { 'on':  'NnnPicker' } 										   " nnn file manager for neovim (requires nnn to be installed)

" Git
Plug 'tpope/vim-fugitive'                                                                  " Git commands in vim (commit, push, status, blame, etc) 
Plug 'tpope/vim-rhubarb'                                                                   " :Gbrowse dari vim-fugitive ke github
Plug 'Xuyuanp/nerdtree-git-plugin'                                                         " Integrasi git dengan Nerd Tree

" Syntax & Code
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }                                         " bar/panel untuk menampilkan deklarasi function,class,property,method,tags dari file
Plug 'sheerun/vim-polyglot'                                                                " Language pack for syntax checking
Plug 'blueyed/smarty.vim'                                                                  " support untuk fipetype smarty (.tpl) bisa pindah antar tag dengan %
Plug 'honza/vim-snippets'                                                                  " kumpulan snippets berbagai bahasa
Plug 'bonsaiben/bootstrap-snippets'                                                        " kumpulan snippet html & bootstrap html yang akan dipakai coc-snippets
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}                                 " autocomplete/error checkong/lint/formatter menggunakan languageServerProtocol langsung (lsp) seperti vscode

" Markdown & Note taking
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install', 'for': 'markdown' }  " Preview file markdown secara real-time
Plug 'godlygeek/tabular'                                                                   " Untuk mensejajarkan apapun (berguna untuk pembuatan dan format table di markdown)
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }                                      " Tambahan syntax dan fitur-fitur untuk file markdown
Plug 'lvht/tagbar-markdown', { 'for': 'markdown' }                                         " tambahan fitur plugin tagbar untuk menampilkan header pada file markdown
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }                                                 " membuat zenmode (mode fokus) untuk menulis tanpa gangguan dan distraksi
Plug 'junegunn/limelight.vim', { 'on': 'Goyo' }                                            " membuat gelap teks paragraf/baris lain & hanya meng-highlight paragraf yang berada di cursor (tambahan untuk goyo)
Plug 'skywind3000/asyncrun.vim', { 'for': 'markdown' }                                     " Menjalankan command2 asyncronous dengan diawali dengan :AsyncRun

" Useful / Essential
Plug 'simeji/winresizer'                                                                   " Easy resize split windows dengan resize mode seperti di i3
Plug 'scrooloose/nerdcommenter'                                         				   " Better code commenter
Plug 'tpope/vim-surround'                                                                  " manipulasi text dengan kurung (){}[]''<>
Plug 'tpope/vim-repeat'                                                                    " membuat key repeat (.) bisa digunakan untuk mapping plugins
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }                          " Remove this if already install fzf
Plug 'junegunn/fzf.vim'                                                                    " Fuzzy file searcher/text finder/buffer searcher/line searcher/tags searcher/commit log finder now on vim
Plug 'moll/vim-bbye'                                                                       " Hapus buffer tanpa menhilangkan window/layout
Plug 'svermeulen/vim-yoink'                                                                " Cycle history yank dengan <alt-p
Plug 'svermeulen/vim-subversive'                                                           " Langsung ganti satu text object dengan register default dengan (s)
Plug 'andymass/vim-matchup'                                                                " fitur tambahan untuk hal2 berpasangan (begin:end, if:endif, if:elseif:else, block function, tags html, dll)
Plug 'chrisbra/Recover.vim' 															   " buat diff saat membuka file yg ada .swp/.swo nya untuk menghapus file .swo/.swpya bisa dengan :FinishRecovery atau :RecoveryPluginFinish

" Colors & Looks
Plug 'itchyny/lightline.vim'                                                               " bar dibawah
Plug 'mengelbrecht/lightline-bufferline'                                                   " bar buffer di atas pengganti bar tab
Plug 'ayu-theme/ayu-vim'                                                                   " Color theme ayu pada vim
Plug 'drewtempelmeyer/palenight.vim'                                                       " Color theme palenight
Plug 'morhetz/gruvbox'                                                                     " Color theme gruvbox
Plug 'frankier/neovim-colors-solarized-truecolor-only'                                     " Color theme solarized (for neovim)
Plug 'joshdick/onedark.vim'
Plug 'mhartington/oceanic-next'
Plug 'mhinz/vim-startify'                                                                  " Start menu saat buka vim tanpa argument
Plug 'chrisbra/Colorizer'                                                                  " Memberi warna pada rgb/hex
Plug 'terryma/vim-smooth-scroll'                                                           " Smooth scroll saat <C-f>/<C-b> <C-u>/<C-d>
Plug 'RRethy/vim-illuminate'                                                               " Highlight kata yang sama dengan yg di cursor pada layar
Plug 'ryanoasis/vim-devicons'

call plug#end()

" # Color and bling
set termguicolors                                                                          " Enable color in gui vim
set t_Co=256                                                                               " Enable 256 True color in terminal vim
set laststatus=2                                                                           " for vim lightline
set showtabline=2                                                                          " Show tabline for lightline bufferline
set noshowmode                                                                             " Menghilangkan tulisan --INSERT-- default karena sudah ada lightline
set cmdheight=1

" " Ayu colorscheme
" let ayucolor="dark" " dark/mirage/light
" colorscheme ayu

" " palenight colorscheme
" set background=dark
" colorscheme palenight
" let g:palenight_terminal_italics=1

" " " gruvbox dark colorscheme
" set bg=dark
" let g:gruvbox_bold = 1
" let g:gruvbox_italic = 1
" let g:gruvbox_underline = 1
" let g:gruvbox_undercurl = 1
" let g:gruvbox_contrast_dark='hard'
" colorscheme gruvbox

" " solarized dark colorscheme
" set bg=dark
" let g:solarized_termcolors=256
" " let g:solarized_degrade = 1
" colorscheme solarized

" let g:onedark_termcolors = 256
" let g:onedark_terminal_italics = 1
" colorscheme onedark

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
colorscheme OceanicNext

" Map leader to space/spasi"
let mapleader = " "

" # General
set encoding=UTF-8
set hidden                               " Pindah ke buffer lain tanpa perlu save
set number                               " Membuat baris nomor di sebelah kiri seperti IDE
set relativenumber                       " Membuat baris nomor relatif dari baris cursor
set cursorline                           " Highlight baris cursor berada
set nowrap                               " Agar text panjang tidak terpotong ke baris selanjutnya (untuk coding)
set title                                " biar keliatan window title nya
set tabstop=4                            " Mengubah tombol <TAB> ketika dipencet jadi 4 spasi
set shiftwidth=4                         " indent 4 spasi
set suffixesadd=.tex,.latex,.md,.php,.js " extension yg akan ditambahkan ke target kalo di 'gf gak ketemu
set updatetime=200                       " Update time untuk plugin-plugin
set shell=/usr/bin/zsh 					 " Set shell jadi zsh
syntax on                                " Memastikan syntax untuk color theme selalu nyala

" disable relativenumber & cursorline in insert mode / disable all line numbers on focusout
augroup numbertoggle
  " autocmd!
  autocmd BufEnter,winEnter,FocusGained,InsertLeave * set number relativenumber cursorline noshowmode
  autocmd BufLeave,winLeave,FocusLost  			    * set nonumber norelativenumber nocursorline
  autocmd InsertEnter               				* set norelativenumber number nocursorline
augroup END

" disable automatic commenting on newline after a comment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" set command mode autocomplete
set wildmenu           " turn on command line completion wild style
set wildmode=list,full " tab completion di command mode sama seperti di terminal

" # Finding text (/ | ?)
set incsearch                   " Highlight text while search
set ignorecase smartcase
set nohlsearch
set completeopt=longest,menuone " better autocompletion
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<DOWN>" |" Ctrl+j autocomplete go down / next
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>" |" Ctrl+k autocomplete go up / previous

" arrow keys disable & UP/DOWN in Command mode
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
cnoremap <C-k> <UP>
cnoremap <C-j> <Down>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>

" Movement in insert mode
inoremap <C-h> <Left>
inoremap <C-l> <Right>
" inoremap <C-j> <Down> (digabung sama completeopt pumvisible())
" inoremap <C-k> <Up> (digabung sama completeopt pumvisible())

" Fast escape (no delay)
vnoremap <Esc> <C-c>
cnoremap <Esc> <C-c>

" x permanent delete
nnoremap x "_x
vnoremap x "_x
nnoremap X "_X
vnoremap X "_X

" kalo mau keluar suka tahan shift kelamaan
cmap Wq wq
cmap Qa qa

" Never go into command line mode
cmap Q! q!
nmap q: :q

" remap Join & show documentation jadi harus tahan shift+alt
noremap <A-J> J
xnoremap <A-J> J
" noremap <A-K> K

" qq to record, Q to replay
nnoremap Q @q

" Source (neo)vimrc & install new plugins
map <F12> :so ~/.config/nvim/init.vim<cr>
map <F11> :so ~/.config/nvim/init.vim<cr> :PlugInstall<cr>

" Pindah ke tags konfirmasi dulu kalo symbol nya ada yang sama
nnoremap <C-]> g<C-]>
nnoremap s<C-]> <C-w>g<C-]> |" buka tag horizontal split
nnoremap sv<C-]> <C-w>vg<C-]> |" buka tag vertical split

" pindahkan baris atas/bawah/kiri/kanan
nnoremap <silent> <A-k> :move-2<cr>
nnoremap <silent> <A-j> :move+<cr>
nnoremap <silent> <A-h> <<
nnoremap <silent> <A-l> >>
xnoremap <silent> <A-k> :move-2<cr>gv
xnoremap <silent> <A-j> :move'>+<cr>gv
xnoremap <silent> <A-h> <gv
xnoremap <silent> <A-l> >gv
xnoremap < <gv
xnoremap > >gv

" delete & yank function
nnoremap <silent> daf Va}ddd
nnoremap <silent> yaf Va}oVy
augroup phpFunction
	autocmd!
	au Filetype php nnoremap <silent> <buffer> daf Va}d2dd
augroup END

" Insert and delete line above & below cursor
nnoremap <silent><A-i> m`:silent +g/\m^\s*$/d<CR>``:noh<CR> |" delete below cursor
nnoremap <silent><A-I> m`:silent -g/\m^\s*$/d<CR>``:noh<CR> |" delete above cursor
nnoremap <silent><A-o> :set paste<CR>m`o<Esc>``:set nopaste<CR> |" insert below cursor
nnoremap <silent><A-O> :set paste<CR>m`O<Esc>``:set nopaste<CR> |" insert above cursor

" nvim terminal mode
noremap <A-t> :sp+te<cr>
tnoremap <C-k> <UP>
tnoremap <C-j> <Down>
tnoremap <C-h> <Left>
tnoremap <C-l> <Right>
tnoremap <buffer> <C-h> <C-\><C-n><C-w>h
tnoremap <buffer> <C-j> <C-\><C-n><C-w>j
tnoremap <buffer> <C-k> <C-\><C-n><C-w>k
tnoremap <buffer> <C-l> <C-\><C-n><C-w>l
tnoremap <Esc> <c-\><c-n>
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
" disable line number & start in insert mode saat buka terminal neovim
augroup termode
	autocmd!
	au TermOpen * startinsert
	au TermOpen * set noruler norelativenumber nonumber laststatus=0
	au BufEnter * if &buftype == 'terminal' | startinsert | endif
	au BufEnter * if &buftype == 'terminal' | set noruler norelativenumber nonumber laststatus=0 | endif
	 \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

" # Clipboard (primary) & Saving
set clipboard=unnamedplus " Mengubah register default vim (saat p) menjadi dari primary register
noremap Y y$
noremap <C-c> "+
inoremap <C-v> <C-r>+
cnoremap <C-v> <C-r>+
noremap <C-s> :update<CR>
vnoremap <C-s> <Esc>:update<CR>
inoremap <C-s> <Esc>:update<CR>

" # Splits
" pindah antar window dengan Ctrl+hjkl
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
" noremap <silent> <leader>0 :call NerdTreeSync(":tablast")<cr>
noremap <silent> <leader>n :call NerdTreeSync(":tabnext")<cr>
noremap <silent> <leader>p :call NerdTreeSync(":tabprev")<cr>
noremap <silent> <leader>t :tabs<cr>
noremap <silent> <C-n> :tabnew<cr>

" leader+a pindah ke recent tab (tab terakhir) pada normal mode & visual mode
au TabLeave * let g:lasttab = tabpagenr()
noremap <silent> <leader>a :exe "tabn ".g:lasttab<cr>

" # Buffers
nmap <silent> J :call NerdTreeSync(":bp")<cr>
nmap <silent> K :call NerdTreeSync(":bn")<cr>
noremap <silent> 'n :call NerdTreeSync(":bn")<cr>
noremap <silent> 'p :call NerdTreeSync(":bp")<cr>
noremap <silent> 'a :call NerdTreeSync(":b#")<cr>
noremap <silent> 'l :call NerdTreeSync(":blast")<cr>
noremap <silent> 'f :call NerdTreeSync(":bfirst")<cr>
noremap <silent> 'd :Bdelete<cr>
nmap <silent> 1' :b1<cr>
nmap <silent> 2' :b2<cr>
nmap <silent> 3' :b3<cr>
nmap <silent> 4' :b4<cr>
nmap <silent> 5' :b5<cr>
nmap <silent> 6' :b6<cr>
nmap <silent> 7' :b7<cr>
nmap <silent> 8' :b8<cr>
nmap <silent> 9' :b9<cr>
" nmap <silent> 0' :b10<cr>

" netrw like nerdree
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" # Functions & Scripts
" Zoom split window yang sedang fokus jadi 1 tab
function! s:zoom()
  if winnr('$') > 1
    tab split
  elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
                  \ 'index(v:val, '.bufnr('').') >= 0')) > 1
    tabclose
  endif
endfunction
noremap <silent> <C-z> :call <sid>zoom()<cr>

" open plugins cheatsheet (invoke with :call Ch())
function! Ch()
    :sp ~/cheatsheet-vim-pluggins
endfunction

function! Log(status)
    if a:status == "start"
        :profile start profile1.log
        :profile func *
        :profile file *
    else
        :profile pause
        :qa!
    endif
endfunction

" copy file path yang lagi di select di nnn ke register
function! CopyLinestoRegister(lines)
	let joined_lines = join(a:lines, "\n")
	if len(a:lines) > 1
		let joined_lines .= "\n"
	endif
	echom joined_lines
	let @+ = joined_lines
endfunction

" set shell jadi zsh dan lakukan 'zgen reset' saat save zshr
autocmd vimenter $DOTFILES/.zshrc,~/.zshrc let &shell='/bin/zsh -i'
autocmd BufWritePost $DOTFILES/.zshrc,~/.zshrc !zgen reset

" menjalankan "xrdb .Xresources" setiap kali .Xresource/.Xdefaults di save 
autocmd BufWritePost ~/.Xresources,~/dotfiles/.Xresources,~/.Xdefaults !xrdb %

" # Markdown
function! ConvertPDFPandoc()
	let realfile = expand('%')
	let file = expand('%:t:r')
    let zareaddir = '~/.zaread/'
    let convertedfile = zareaddir. file . '.pdf'
	redraw
    echo 'deleting old file '. convertedfile
    execute "!rm -f " . convertedfile
    echo 'converting to pdf'
    " execute "!pandoc " . realfile . " -o " . convertedfile . " --template eisvogel --listings --pdf-engine=xelatex -V disable-header-and-footer -V listings-no-page-break"
    execute "AsyncRun pandoc " . realfile . " -o " . convertedfile . " --template eisvogel --listings --pdf-engine=xelatex -V disable-header-and-footer -V listings-no-page-break"
	redraw
endfunction

function! PreviewMdZathura()
	let realfile = expand('%')
	let zareaddir = '~/.zaread/'
	let file = expand('%:t:r')
	let convertedfile = zareaddir. file . '.pdf'
	" execute "!pandoc " . realfile . " -o " . convertedfile . " --template eisvogel --listings --pdf-engine=xelatex -V disable-header-and-footer -V listings-no-page-break"
	if !empty(glob(convertedfile))
		execute "!zathura " . convertedfile
	else
		execute "echo 'compiling new pdf...'"
		execute "AsyncRun ~/.i3/scripts/zaread " . realfile
	endif
endfunction

" Saat write pada file markdown hapus cache pdf dari zaread agar nanti bisa dibuat baru | buka file dengan zathura
au BufWritePost *.md call ConvertPDFPandoc()
au Filetype markdown noremap <leader>z :call PreviewMdZathura()<cr><cr>

augroup mdsettings
	autocmd!
	au BufRead,BufEnter index.md setlocal nofoldenable          " disable folding saat pertama kali masuk pada index personal notes saya
	au BufRead,BufEnter index.md noremap <buffer> <cr> f]2lgf   " buka catatan di baris cursor dengan enter (pada index.md)
	au Filetype markdown setlocal conceallevel=2 wrap linebreak " writing mode setup
" gerak atas/bawah pada satu kalimat yang sudah di wrap
	au Filetype markdown noremap j gj
	au Filetype markdown noremap k gk
augroup END

let php_sql_query=1 " Syntax highlighting pada string query sql dalam php

" # Plugins

" vim illuminate filetype blacklist & highlight with underline
" let g:Illuminate_ftblacklist = ['html','smarty']
" hi illuminatedWord cterm=underline gui=underline

" vim matchup matchparen highlight cursor delay
let g:matchup_matchparen_deferred = 1
" let g:matchup_matchparen_status_offscreen = 0
let g:matchup_matchparen_timeout = 300
let g:matchup_matchparen_insert_timeout = 60

"  AsyncRun membuat make & git push menjadi asyncronous
" command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>

" fugitive-vim git keymaps
noremap <silent> <leader>gB :Gblame<cr>
noremap <silent> <leader>gs :Gstatus<cr>
noremap <silent> <leader>gd :Gdiff<cr>
noremap <silent> <leader>gc :Gcommit<cr>
noremap <silent> <leader>gp :Gpush<cr>
" from fzf.vim
noremap <silent> <leader>gl :Commits<cr>
noremap <silent> <leader>g'l :BCommits<cr>

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

" let g:lightline.colorscheme = 'ayu'
" let g:lightline.colorscheme = 'gruvbox'
" let g:lightline.colorscheme = 'solarized'
 " let g:lightline.colorscheme = 'onedark'
  let g:lightline.colorscheme = 'oceanicnext'
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
  " return winwidth(0) > 115 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
  return strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft'
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
	let buffers = len(getbufinfo({'buflisted':1}))
	let tabs = tabpagenr() . '/' . tabpagenr('$')
	return buffers . ' ' . 'Buffers  '. '' . ' ' . tabs . ' ' .'Tabs  '
endfunction

" nnn file manager
let g:nnn#set_default_mappings = 0

nnoremap <silent> <leader><C-e> :NnnPicker<CR>
" Start nnn in the current file's directory
nnoremap <leader>e :NnnPicker '%:p:h'<CR>

" Opens the nnn window in a split
"let g:nnn#layout = 'tabnew' " or vnew, tabnew etc.
let g:nnn#layout = { 'left': '~20%' } " or right, up, down
let g:nnn#action = {
      \ '<c-t>': 'tab split',
      \ '<c-s>': 'split',
      \ '<c-v>': 'vsplit', 
	  \ '<c-c>': function('CopyLinestoRegister') } " copy full path file yang dipilih ke register

let g:nnn#command = 'nnn -l' " buat nnn minimal mode (gak ada file information) & find as you type

"noremap <leader>t :NERDTreeToggle<CR>
noremap <silent> <leader>E :call NerdTreeSync(":NERDTreeToggle")<cr>
" noremap <silent> <leader>E :call NerdTreeSync(":NERDTreeTabsToggle")<cr>
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

" NERDCommenter
let g:NERDCustomDelimiters = {
			\'smarty': { 'left': '<!--','right': '-->', 'leftAlt': '/*', 'rightAlt': '*/'},
			\'html': { 'left': '<!--','right': '-->', 'leftAlt': '/*', 'rightAlt': '*/'},
			\'vim': { 'left': '"'} } 
let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default
let g:NERDCompactSexyComs = 1 " Use compact syntax for prettified multi-line comments
let g:NERDDefaultAlign = 'left' " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDCommentEmptyLines = 1 " Comment empty lines (useful for regions)
let g:NERDTrimTrailingWhitespace = 1 " Trim trailing white space when uncommenting
let g:NERDToggleCheckAllLines = 1 " Enable NERDCommenterToggle to check all selected lines is commented or not 

nmap gcc <plug>NERDCommenterToggle
nmap gcU <plug>NERDCommenterComment
nmap gcu <plug>NERDCommenterUncomment
nmap gcC <plug>NERDCommenterToEOL |" Comment dari cursor ke EOL
nmap gci <plug>NERDCommenterInvert |" Invert baris yang sudah di comment jadi uncomment dan sebaliknya
nmap gcm <plug>NERDCommenterMinimal |" Comment multiple line
nmap gcs <plug>NERDCommenterSexy |" Comment multiple line dipercantik
nmap gcy <plug>NERDCommenterYank |" copy (Yank) baris lalu comment
nmap gcA <plug>NERDCommenterAppend |" Memulai comment dari akhir baris
nmap gcv <plug>NERDCommenterAltDelims |" Switch alternative comments (ex: di php "//" & "/* */")
" comment paragraf
nmap gcap  vapgcs 
nmap 2gcap v2apgcs
nmap 3gcap v3apgcs
nmap gcip  vipgcm
nmap 2gcip v2ipgcm
nmap 3gcip v3ipgcm

" comment paragraf untuk filetype yang gak ada multiline comment nya
augroup commentmultiple
	autocmd!
	au filetype vim,conf,xdefaults nmap <buffer> gcap vapgcc
	au filetype vim,conf,xdefaults nmap <buffer> 2gcap v2apgcc
	au filetype vim,conf,xdefaults nmap <buffer> 3gcap v3apgcc
	au filetype vim,conf,xdefaults nmap <buffer> gcip vipgcc
	au filetype vim,conf,xdefaults nmap <buffer> 2gcip v2ipgcc
	au filetype vim,conf,xdefaults nmap <buffer> 3gcip v3ipgcc
augroup END

xmap gcc <plug>NERDCommenterToggle
xmap gcU <plug>NERDCommenterComment
xmap gcu <plug>NERDCommenterUncomment
xmap gci <plug>NERDCommenterInvert
xmap gcm <plug>NERDCommenterMinimal
xmap gcs <plug>NERDCommenterSexy
xmap gcy <plug>NERDCommenterYank

imap <C-c> <plug>NERDCommenterInsert

" silent! call repeat#set("\<Plug>NERDCommenterToggle", v:count)

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
noremap <silent> <C-Space> :Buffers<cr>
noremap <silent> <leader>l :BLines<cr>
noremap <silent> <leader>L :Lines<cr>
noremap <silent> <leader>] :BTags<cr>
noremap <silent> <leader>} :Tags<cr>

" keluar dari fzf dengan <Esc> dan hilangkan command window di bawah (nvim)
autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>
autocmd  FileType fzf set laststatus=0 noshowmode noruler norelativenumber
\| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

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
let $FZF_DEFAULT_OPTS="--no-mouse --height 70% -1 --reverse --inline-info --color=dark,bg:8"

let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
	let buf = nvim_create_buf(v:false, v:true)
	call setbufvar(buf, '&signcolumn', 'no')

	let height = &lines - 3
	let width = float2nr(&columns - (&columns * 2 / 5))
	let col = float2nr((&columns - width) / 2)

	let opts = {
				\ 'relative': 'editor',
				\ 'row': 1,
				\ 'col': col,
				\ 'width': width,
				\ 'height': height
				\ }

	let win = nvim_open_win(buf, v:true, opts)
	call setwinvar(win, '&number', 0)
endfunction

" " Vim smooth scroll
" noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
" noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

" vim-yoink
nmap <A-p> <plug>(YoinkPostPasteSwapBack)
nmap <A-P> <plug>(YoinkPostPasteSwapForward)
nmap <A-=> <plug>(YoinkPostPasteToggleFormat)
nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)

" copy deletion (c,d,x) to vim yoink | work across files (neovim) | include named register (a,b,s,d,etc) to vim-yoink
let g:yoinkIncludeDeleteOperations = 1
let g:yoinkSavePersistently = 1
let g:yoinkIncludeNamedRegisters = 1
let g:yoinkAutoFormatPaste = 1

" vim-subversive
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)

" vim-subversive pada visual mode
xmap s <plug>(SubversiveSubstitute)
xmap p <plug>(SubversiveSubstitute)
xmap P <plug>(SubversiveSubstitute)

" map tagbar & focus to opened tagbar 
noremap <silent> <leader>b :TagbarToggle<cr>
noremap <silent> <leader>B :TagbarOpen j<cr>

" remove help sign |  for markdown tagbar open on left & sort according to file
let g:tagbar_compact = 1
let g:tagbar_autoshowtag = 1
au Filetype markdown let g:tagbar_left = 1
au Filetype markdown let g:tagbar_sort = 0

" polygot disable markdown syntax (already have markdown plugin)
let g:polyglot_disabled = ['markdown']

" markdown live preview set browser & disable auto start when opening/close when leaving
let g:mkdp_browser = 'qutebrowser'
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 0
au Filetype markdown noremap <leader>v :MarkdownPreview<cr>

" Goyo & Limelight
noremap <silent> <A-g> :Goyo<cr>
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Set filetype apa aja colorhighlighting akan aktif
let g:colorizer_auto_filetype='css,html,xdefaults,conf,config,yaml,dosini,cfg'

" CoC vim
" filetype yang akan di deteksi oleh coc (javascriptreact = javascript)
let g:coc_filetype_map = {
	\ 'smarty': 'html',
	\ 'javascriptreact': 'javascript'
	\ }

" Coc pairs disable (") untuk config vim & enable (*)(~) untuk markdown
au FileType vim let b:coc_pairs_disabled = ['"']
au FileType markdown let b:coc_pairs = [["*", "*"],["~", "~"]]

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" <Tab>/Shift+<Tab> & Ctrl+j/Ctrl+k untuk cycle atas bawah completion | enter untuk pilih completion | Ctrl+spasi untuk refresh kembali completion
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <c-space> coc#refresh()

" loncat diagnostic coc
noremap <silent> [c <Plug>(coc-diagnostic-prev)
noremap <silent> ]c <Plug>(coc-diagnostic-next)

" Coc go-to definition/type/implementation/references
nmap <silent> <leader>cd  <Plug>(coc-definition)
nmap <silent> <leader>ct <Plug>(coc-type-definition)
nmap <silent> <leader>ci <Plug>(coc-implementation)
nmap <silent> <leader>cr <Plug>(coc-references)

" format menggunakan lsp dari coc dengan <leader>f+<motion> atau pilih dulu dari visual mode & Format satu file
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
noremap <leader>F :call CocAction('format')<CR>

" coc do code action & quick fix
nmap <leader>ca  <Plug>(coc-codeaction)
nmap <leader>cf  <Plug>(coc-fix-current)

" coc-git navigate ke sebelumnya/berikutnya
nmap ]h <Plug>(coc-git-nextchunk)
nmap [h <Plug>(coc-git-prevchunk)

" coc-git undo hunk | hunk preview (diff dari yang sebelum diubah) | lihat commit dari git blame di baris cursor
nmap <silent> <leader>hu :CocCommand git.chunkUndo<cr>
nmap <leader>hp <Plug>(coc-git-chunkinfo)
nmap <leader>gb <Plug>(coc-git-commit)

" coc previewa definition, kalo gak ketemu maka default ke (K) dari vim yaitu buka documentation sesuai kata yg di cursor
noremap <silent> <A-K> :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! s:check_back_space() abort
	let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" markdown code fence language alias
let g:vim_markdown_fenced_languages = ['js=javascript','bash=sh']
" let g:vim_markdown_folding_style_pythonic = 1
" Bookmark buat plugin vim-startify
let g:startify_bookmarks = [ {'v': '$DOTFILES/.config/nvim/init.vim'},
			   \ {'x': '$DOTFILES/.Xresources'},
			   \ {'i': '$DOTFILES/.i3/config'},
			   \ {'n': '$NOTES/index.md'},
			   \ {'z': '$DOTFILES/.zshrc'}]

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

let g:startify_session_dir = '~/.config/nvim/session'

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
