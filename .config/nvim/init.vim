"     _   ___ __       _          _       _ __        _         
"    / | / (_) /_____ ( )_____   (_)___  (_) /__   __(_)___ ___ 
"   /  |/ / / __/ __ \|// ___/  / / __ \/ / __/ | / / / __ `__ \
"  / /|  / / /_/ /_/ / (__  )  / / / / / / /__| |/ / / / / / / /
" /_/ |_/_/\__/\____/ /____/  /_/_/ /_/_/\__(_)___/_/_/ /_/ /_/ 

" Vim-plug plugin manager init / install baru kalau belum di install
" :PlugInstall (Install semua plugin yang disebutkan dibawah)
" :PlugClean (Uninnstall semua plugin yang dihapus dari bawah)
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
else

let g:pluginsDir = '~/.config/nvim/vim-plug-pluggins'
call plug#begin(pluginsDir)

" File Explorer
Plug 'scrooloose/nerdtree', { 'on':  ['NERDTreeToggle', 'NERDTreeTabsToggle'] }   
Plug 'jistr/vim-nerdtree-tabs', { 'on':  'NERDTreeTabsToggle' }
Plug 'justinmk/vim-dirvish'                                                                " File explorer pengganti netrw

" Git
Plug 'tpope/vim-fugitive'                                                                  " Git commands in vim (commit, push, status, blame, etc) 
Plug 'tpope/vim-rhubarb'                                                                   " :Gbrowse dari vim-fugitive ke github
Plug 'Xuyuanp/nerdtree-git-plugin'                                                         " Integrasi git dengan Nerd Tree
Plug 'rhysd/git-messenger.vim'

" Syntax & Code
Plug 'diepm/vim-rest-console', { 'for': 'rest' }
Plug 'majutsushi/tagbar', { 'on': ['TagbarToggle', 'TagbarOpen'] }                         " Bar/panel untuk menampilkan deklarasi function,class,property,method,tags dari file
Plug 'sheerun/vim-polyglot'                                                                " Language pack for syntax checking,
Plug 'blueyed/smarty.vim'                                                                  " support untuk fipetype smarty (.tpl) bisa pindah antar tag dengan %
Plug 'honza/vim-snippets'                                                                  " kumpulan snippets berbagai bahasa
Plug 'bonsaiben/bootstrap-snippets'                                                        " kumpulan snippet html & bootstrap html yang akan dipakai coc-snippets
Plug 'neoclide/coc.nvim', {'branch': 'release'}                                            " autocomplete/error checkong/lint/formatter menggunakan languageServerProtocol langsung (lsp) seperti vscode
Plug 'cosminadrianpopescu/vim-sql-workbench', { 'on': 'SWSqlBufferConnect' }

" Markdown & Note taking
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install', 'on': 'MarkdownPreview', 'for': 'markdown' }  " Preview file markdown secara real-time
Plug 'godlygeek/tabular', { 'on': ['Tab','Tabular'] }                                                                   " Untuk mensejajarkan apapun (berguna untuk pembuatan dan format table di markdown)
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }                                      " Tambahan syntax dan fitur-fitur untuk file markdown
Plug 'lvht/tagbar-markdown', { 'for': 'markdown' }                                         " tambahan fitur plugin tagbar untuk menampilkan header pada file markdown
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }                                                 " membuat zenmode (mode fokus) untuk menulis tanpa gangguan dan distraksi
Plug 'junegunn/limelight.vim', { 'on': 'Goyo' }                                            " membuat gelap teks paragraf/baris lain & hanya meng-highlight paragraf yang berada di cursor (tambahan untuk goyo)
Plug 'skywind3000/asyncrun.vim', { 'for': 'markdown' }                                     " Menjalankan command2 asyncronous dengan diawali dengan :AsyncRun

" Useful / Essential
let nerdcommenter_commands = [ '<plug>NERDCommenterToggle', 
            \ '<plug>NERDCommenterComment', 
            \ '<plug>NERDCommenterUncomment',
            \ '<plug>NERDCommenterToEOL',
            \ '<plug>NERDCommenterInvert',
            \ '<plug>NERDCommenterMinimal',
            \ '<plug>NERDCommenterSexy',
            \ '<plug>NERDCommenterYank',
            \ '<plug>NERDCommenterAppend',
            \ '<plug>NERDCommenterAltDelims' ]
Plug 'scrooloose/nerdcommenter', { 'on' : nerdcommenter_commands }                         " Better code commenter
Plug 'simeji/winresizer', { 'on': 'WinResizerStartResize' }
Plug 'tpope/vim-surround'                                                                  " manipulasi text dengan kurung (){}[]''<>
Plug 'tpope/vim-repeat'                                                                    " membuat key repeat (.) bisa digunakan untuk mapping plugins
let fzf_commands = [ 'Files', 
                \ 'Buffers', 
                \ 'BLines',
                \ 'Lines',
                \ 'Rg',
                \ 'BTags',
                \ 'Tags',
                \ 'Commits',
                \ 'BCommits',
                \ 'Helptags',
                \ 'Colors',
                \ '<plug>(fzf-complete-word)',
                \ '<plug>(fzf-complete-path)',
                \ '<plug>(fzf-complete-file-ag)',
                \ '<plug>(fzf-complete-line)' ]

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all', 'on': fzf_commands}       " Remove this if already install fzf
Plug 'junegunn/fzf.vim', {'on': fzf_commands}                                              " Fuzzy file searcher/text finder/buffer searcher/line searcher/tags searcher/commit log finder now on vim
Plug 'moll/vim-bbye'                                                                       " Hapus buffer tanpa menhilangkan window/layout
Plug 'svermeulen/vim-yoink'                                                                " Cycle history yank dengan <alt-p
Plug 'svermeulen/vim-subversive'                                                           " Langsung ganti satu text object dengan register default dengan (s)
Plug 'andymass/vim-matchup'                                                                " fitur tambahan untuk hal2 berpasangan (begin:end, if:endif, if:elseif:else, block function, tags html, dll)
Plug 'christoomey/vim-tmux-navigator'                                                      " Integrasi split panes dengan pane tmux (C-hjkl antara split di vim dengan split pane tmux)

" Colors & Looks
Plug 'itchyny/lightline.vim'                                                               " bar dibawah
Plug 'mengelbrecht/lightline-bufferline'                                                   " bar buffer di atas pengganti bar tab
Plug 'ayu-theme/ayu-vim'                                                                   " Color theme ayu pada vim
Plug 'drewtempelmeyer/palenight.vim'                                                       " Color theme palenight
Plug 'morhetz/gruvbox'                                                                     " Color theme gruvbox
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'whatyouhide/vim-gotham'
Plug 'frankier/neovim-colors-solarized-truecolor-only'                                     " Color theme solarized (for neovim)
Plug 'millenito/oceanic-next-darker' 													   " Personal fork of Oceanic Next Color theme
Plug 'cocopon/iceberg.vim'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'mhinz/vim-startify'                                                                  " Start menu saat buka vim tanpa argument
" Plug 'chrisbra/Colorizer', { 'on': 'ColorToggle'}                                                                  " Memberi warna pada rgb/hex
Plug 'chrisbra/Colorizer'                                                                  " Memberi warna pada rgb/hex
Plug 'psliwka/vim-smoothie'                                                                " Smooth scroll saat <C-f>/<C-b> <C-u>/<C-d>
Plug 'RRethy/vim-illuminate'                                                               " Highlight kata yang sama dengan yg di cursor pada layar
Plug 'ryanoasis/vim-devicons'

Plug 'michaeljsmith/vim-indent-object'                                                     " Text object untuk indent <motion>ii (in indent), <motion>ai (above indent), <motion>aI <above and below indent)
Plug 'tweekmonster/startuptime.vim', { 'on' : 'StartupTime' }
call plug#end()

endif
" # Color and bling
set termguicolors                                                                          " Enable color in gui vim
set t_Co=256                                                                               " Enable 256 True color in terminal vim
set laststatus=2                                                                           " for vim lightline
" set showtabline=2                                                                          " Show tabline for lightline bufferline
set noshowmode                                                                             " Menghilangkan tulisan --INSERT-- default karena sudah ada lightline
set cmdheight=1

" " Ayu colorscheme
" let ayucolor="dark" " dark/mirage/light
" colorscheme ayu

" " palenight colorscheme
" set background=dark
" colorscheme palenight
" let g:palenight_terminal_italics=1

" " gruvbox dark colorscheme
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

" colorscheme iceberg

" colorscheme challenger_deep

au ColorScheme dracula hi MatchWord ctermbg=Green ctermfg=White guibg=Green guifg=White gui=bold cterm=bold
let g:dracula_bold = 1
let g:dracula_italic = 1
let g:dracula_underline = 1
let g:dracula_undercurl = 1
colorscheme dracula

" colorscheme gotham
" colorscheme gotham256

" let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" let g:oceanic_next_terminal_bold = 1
" let g:oceanic_next_terminal_italic = 1
" colorscheme OceanicNextDarker

" Map leader to space/spasi"
let mapleader = " "

" # General
set encoding=UTF-8
set hidden                               " Pindah ke buffer lain tanpa perlu save
" set number                               " Membuat baris nomor di sebelah kiri seperti IDE
" set relativenumber                       " Membuat baris nomor relatif dari baris cursor
" set cursorline                           " Highlight baris cursor berada
set lazyredraw
set nowrap                               " Agar text panjang tidak terpotong ke baris selanjutnya (untuk coding)
set title                                " biar keliatan window title nya
set tabstop=4                            " Mengubah tombol <TAB> ketika dipencet jadi 4 spasi
set expandtab
set shiftwidth=4                         " indent 4 spasi
set suffixesadd=.tex,.latex,.md,.php,.js " extension yg akan ditambahkan ke target kalo di 'gf gak ketemu
set updatetime=200                       " Update time untuk plugin-plugin
set shell=/usr/bin/zsh 					 " Set shell jadi zsh
" set winblend=20
syntax on                                " Memastikan syntax untuk color theme selalu nyala
" disable relativenumber & cursorline in insert mode / disable all line numbers on focusout
augroup numbertoggle
  autocmd!
  autocmd BufEnter,winEnter,FocusGained,InsertLeave * set number relativenumber  noshowmode "cursorline
  autocmd BufLeave,winLeave,FocusLost  			    * set number norelativenumber "nocursorline
  autocmd InsertEnter               				* set norelativenumber number  "nocursorline
augroup END

augroup autoreadfile
    autocmd!
    " Triger `autoread` when files changes on disk
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif

    " Notification after file change
    autocmd FileChangedShellPost *
            \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
augroup END
" disable automatic commenting on newline after a comment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd VimResized * wincmd =

" set command mode autocomplete
set wildmenu           " turn on command line completion wild style
" set wildmode=list:full " tab completion di command mode sama seperti di terminal
" set wildmode=longest:full " tab completion di command mode sama seperti di terminal
set wildmode=longest:full,full

" # Finding text (/ | ?)
set incsearch                   " Highlight text while search
set ignorecase smartcase        " ignore case when searching except when text have capital
set wrapscan
" set nohlsearch
set completeopt=longest,menuone " better autocompletion
noremap <silent> <esc> :nohl<CR>
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<DOWN>" |" Ctrl+j autocomplete go down / next
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>" |" Ctrl+k autocomplete go up / previous

" Movement in insert mode
inoremap <C-h> <Left>
inoremap <C-l> <Right>
" inoremap <C-j> <Down> (digabung sama completeopt pumvisible())
" inoremap <C-k> <Up> (digabung sama completeopt pumvisible())

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
cnoremap  <M-n> <Down>
cnoremap  <M-p> <Up>

function! s:ctrl_u()
    if getcmdpos() > 1
        let @- = getcmdline()[:getcmdpos()-2]
    endif
    return "\<C-U>"
endfunction

cnoremap <expr> <C-U> <SID>ctrl_u()

" Fast escape (no delay)
vnoremap <Esc> <C-c>
cnoremap <Esc> <C-c>

" x permanent delete
nnoremap x "_x
vnoremap x "_x
nnoremap X "_X
vnoremap X "_X

" kalo mau keluar suka tahan shift kelamaan
command! WQ wq
command! Wq wq
command! W w
command! Q q
command! Qa qa

" Close vim
nmap <C-q> :q<cr>

" Toggle paste mode
set pastetoggle=<F2>

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

" Insert new line above/below cursor
nnoremap <silent> <cr> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent> <bs> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" Fix for using <cr> key (Enter) in quickfix window because of previous mapping
autocmd CmdwinEnter * nnoremap <CR> <CR>
autocmd BufReadPost quickfix nnoremap <CR> <CR>

" Delete new line above/below cursor
nnoremap <silent> ]d m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent> [d m`:silent -g/\m^\s*$/d<CR>``:noh<CR>

" # Clipboard (primary) & Saving
set clipboard=unnamedplus,unnamed " Mengubah register default vim (saat p) menjadi dari primary register
noremap Y y$
noremap <C-c> "+
inoremap <C-v> <C-r>+
cnoremap <C-v> <C-r>+
noremap <C-s> :update<CR>
vnoremap <C-s> <Esc>:update<CR>
inoremap <C-s> <Esc>:update<CR>

" Persisten undo after closing file
set undodir=~/.config/nvim/undodir
set undofile

" Folds
set foldmethod=syntax " fold by indents
" set foldcolumn=1 "defines 1 col at window left, to indicate folding
let javaScript_fold=1 "activate folding by JS syntax
set foldlevelstart=999 "start file with all folds opened

" Toggle fold & toggle folds recursively in cursor
noremap - za
noremap _ zA

" # Splits
" pindah antar window dengan Ctrl+hjkl
if !exists(':TmuxNavigatorProcessList')
    noremap <C-k> <C-w>k
    noremap <C-j> <C-w>j
    noremap <C-h> <C-w>h
    noremap <C-l> <C-w>l
endif
noremap <C-w>f <C-w>\|<C-w>_ |" zoom maximize split pane dengan cara di resize sampe mentok (untuk normalin lagi <C-w>0)
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
" Remap <C-t> from jump back tag stack to <leader>t
noremap <silent> <leader>t <C-t>
noremap <silent> <C-t> :tabnew<cr>

" leader+a pindah ke recent tab (tab terakhir) pada normal mode & visual mode
au TabLeave * let g:lasttab = tabpagenr()
noremap <silent> <leader>a :exe "tabn ".g:lasttab<cr>

" # Buffers
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

" List semua buffer sambil menunggu buffer untuk dipilih (mengganti pane atau buka split/vsplit baru)
noremap 'w :ls<CR>:b<Space>
noremap 's :ls<CR>:sb<Space>
noremap 'v :ls<CR>:vertical sb<Space>

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

" set shell jadi zsh dan lakukan 'zgen reset' saat save zshr
autocmd vimenter $DOTFILES/.zshrc,~/.zshrc let &shell='/bin/zsh -i'
autocmd BufWritePost $DOTFILES/.zshrc,~/.zshrc !zgen reset

" menjalankan "xrdb .Xresources" setiap kali .Xresource/.Xdefaults di save 
autocmd BufWritePost ~/.Xresources,~/dotfiles/.Xresources,~/.Xdefaults !xrdb %

" autocmd CursorHold * :checktime

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

" Convert markdown ke file .html ke directory khusus untuk html yang berada di directory utama $NOTES (/home/nito/notes)
" dengan struktur yang sama dengan file markdown (otomatis buat folder yang diperlukan)
function! ConvertHTMLPandoc()
    let notesdir = $NOTES
	let converteddir = notesdir . "/_html"
	let realfile = expand('%:p')

	if realfile == notesdir . "/index.md"
		let indexhtml = converteddir . '/' . expand('%:t:r') . '.html'
		execute "AsyncRun pandoc " . realfile . " -o " . indexhtml . " --template=uikit.html --toc"
	else
		let matched = matchlist(expand("%:p"), '\v' . notesdir . '(/.+)(/[^/]+)\.md$')
		let convertedfile = converteddir . matched[1] . matched[2]  . ".html"
		let newdir = matchstr(convertedfile, '.*\/')

		if !isdirectory(newdir)
			echo "directory didn't exist, creating new directory"
			call mkdir(newdir, "p")
		endif

		echo 'deleting old file '. convertedfile
		execute "!rm -f " . convertedfile
		echo 'converting to html'
		execute "AsyncRun pandoc " . realfile . " -o " . convertedfile . " --template=uikit.html --toc"
		" execute "AsyncRun pandoc " . realfile . " -o " . convertedfile . " --template=uikit.html --toc --self-contained --resource-path=.:$NOTES/_images"
	endif
endfunction

function! PreviewMdPDF()
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

" Buka file markdown yang sudah di convert ke .html dengan qutebrowser
function! PreviewMdHTML()
	let realfile = expand('%:p')
	let filedir = expand('%:p:h') . '/html/'
	let file = expand('%:t:r')
	let convertedfile = filedir . file . '.html'
	if !empty(glob(convertedfile))
		execute "!qutebrowser " . convertedfile
	else
		execute "echo 'compiling new html...'"
		execute "AsyncRun pandoc " . realfile . " -o " . convertedfile . " --template=uikit.html --toc"
		execute "!qutebrowser " . convertedfile
	endif
endfunction

" Saat write pada file markdown hapus cache pdf dari zaread agar nanti bisa dibuat baru | buka file dengan zathura
au BufWritePost $NOTES/**.md call ConvertHTMLPandoc()
" au BufWritePost *.md call ConvertPDFPandoc()
au Filetype markdown noremap <leader>z :call PreviewMdPDF()<cr><cr>

augroup mdSettings
	autocmd!
	au BufRead,BufEnter index.md setlocal nofoldenable          " disable folding saat pertama kali masuk pada index personal notes saya
	au BufRead,BufEnter index.md noremap <buffer> <cr> f]2lgf   " buka catatan di baris cursor dengan enter (pada index.md)
    au Filetype markdown setlocal conceallevel=0 wrap linebreak " writing mode setup

	" gerak atas/bawah pada satu kalimat yang sudah di wrap
	au Filetype markdown noremap j gj
	au Filetype markdown noremap k gk

	" Loncat ke yang ada tanda <++>
    au Filetype markdown inoremap ,, <Esc>/<++><Enter>"_c4l
    au Filetype markdown vnoremap ,, <Esc>/<++><Enter>"_c4l
    au Filetype markdown map ,, <Esc>/<++><Enter>"_c4l

	" Markdown maps
	au Filetype markdown inoremap ,b **** <++><Esc>F*hi
	au Filetype markdown nnoremap ,b bi**<Esc>ea**<Esc>
	au Filetype markdown inoremap ,s ~~~~ <++><Esc>F~hi
	au Filetype markdown nnoremap ,s bi~~<Esc>ea~~<Esc>
	au Filetype markdown inoremap ,c `` <++><Esc>F`ha
	au Filetype markdown nnoremap ,c bi`<Esc>ea`<Esc>
	au Filetype markdown inoremap ,i ** <++><Esc>F*ha
	au Filetype markdown nnoremap ,i bi*<Esc>ea*<Esc>
	au Filetype markdown inoremap ,e ****** <++><Esc>F*2hi
	au Filetype markdown nnoremap ,e bi***<Esc>ea***<Esc>
	au Filetype markdown inoremap ,m <mark></mark> <++><Esc>F/hi
	au Filetype markdown nnoremap ,m bi<mark><Esc>ea</mark><Esc>
augroup END

augroup dartSettings
    au BufRead,BufEnter dart.snippets setlocal tabstop=2 shiftwidth=2
    au Filetype dart setlocal tabstop=2 shiftwidth=2
    au BufEnter,BufRead,VimEnter *.dart call Flutter_coc()

    function! Flutter_coc()
        if exists(':CocCommand')
            nnoremap <C-s> :update<cr>:CocCommand flutter.dev.hotReload<cr>
            xnoremap <C-s> <esc>:update<cr>:CocCommand flutter.dev.hotReload<cr>
            inoremap <C-s> <esc>:update<cr>:CocCommand flutter.dev.hotReload<cr>
            nnoremap <leader>R :CocCommand flutter.dev.hotRestart<cr>
            noremap <leader>f :CocList --input=flutter commands<cr>
        endif
    endfunction
augroup end

augroup tomlSettings
    au BufRead,BufEnter toml.snippets setlocal tabstop=2 shiftwidth=2
    au Filetype toml setlocal tabstop=2 shiftwidth=2
augroup end

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
let g:asyncrun_exit = "echo 'finished compiling!'"

" fugitive-vim git keymaps
noremap <silent> <leader>gB :Gblame<cr>
noremap <silent> <leader>gs :Gstatus<cr>
noremap <silent> <leader>gd :Gdiff<cr>
noremap <silent> <leader>gc :Gcommit<cr>
noremap <silent> <leader>gp :Gpush<cr>
" from fzf.vim
noremap <silent> <leader>gl :Commits!<cr>
noremap <silent> <leader>g'l :BCommits!<cr>

let g:lightline = {
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [  'readonly', 'filename'] ]
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
" let g:lightline.colorscheme = 'palenight'
" let g:lightline.colorscheme = 'gruvbox'
" let g:lightline.colorscheme = 'solarized'
" let g:lightline.colorscheme = 'iceberg'
" let g:lightline.colorscheme = 'oceanicnextdarker'
let g:lightline.colorscheme = 'dracula'
" let g:lightline.colorscheme = 'gotham'
" let g:lightline = { 'colorscheme': 'challenger_deep'}
" let g:lightline.tabline          = {'left': [['buffers']], 'right': [['tabinfo']]}
let g:lightline.tabline          = { 'right': [['tabinfo']]}
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

" Dirvish
" Gunakan dirvish dan disable netrw kalo ada dirvish
autocmd VimEnter * call Load_Dirvish_Netrw()
function! Load_Dirvish_Netrw()
    if exists(':Dirvish')
        let g:loaded_netrw       = 1
        let g:loaded_netrwPlugin = 0
        let g:dirvish_mode       = ':sort ,^.*[\/],'

        " Change default Explore, Vexplore, Sexplore to using dirvish
        command! -nargs=? -complete=dir Explore Dirvish <args>
        command! -nargs=? -complete=dir Vexplore  vsplit | silent Dirvish <args>
        command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>

        " Dirvish on the left
        command! VleftDirvish leftabove vsplit | vertical resize 30 | silent Dirvish
        nnoremap <silent> <leader>E :VleftDirvish<CR>

        " Open dirvish on current pane/ vertically from current pane/ horizontally from current pane (use capitals for opening in CWD)
        nnoremap <silent> <leader>W :Explore<CR>
        nnoremap <silent> <leader>S :Sexplore<cr>
        nnoremap <silent> <leader>V :Vexplore<cr>
        nnoremap <silent> <leader>w :Explore %:p:h<CR>
        nnoremap <silent> <leader>s :Sexplore %:p:h<cr>
        nnoremap <silent> <leader>v :Vexplore %:p:h<cr>

        augroup dirvishSettings
            autocmd!
            autocmd FileType dirvish silent! unmap <buffer> <C-p>
            autocmd FileType dirvish silent! unmap <buffer> <Cr>

            " Go up / enter directory easily
            au FileType dirvish nmap <silent><buffer> h <Plug>(dirvish_up)
            au FileType dirvish nmap <silent><buffer> l :call dirvish#open("edit", 0)<CR>

            " Ctrl+t open in new tap
            au FileType dirvish nnoremap <silent><buffer> <C-t> :call dirvish#open('tabedit', 0)<CR>
            au FileType dirvish xnoremap <silent><buffer> <C-t> :call dirvish#open('tabedit', 0)<CR>

            " Ctrl+s open in horizontal split
            au FileType dirvish nnoremap <silent><buffer> <M-s> :call dirvish#open('split', 0)<CR>
            au FileType dirvish xnoremap <silent><buffer> <M-s> :call dirvish#open('split', 0)<CR>

            " Ctrl+v open in vertical split
            au FileType dirvish nnoremap <silent><buffer> <M-v> :call dirvish#open('vsplit', 0)<CR>
            au FileType dirvish xnoremap <silent><buffer> <M-v> :call dirvish#open('vsplit', 0)<CR>

            " Map `gr` to reload.
            au FileType dirvish nnoremap <silent><buffer> gr :<C-U>Dirvish %<CR>

            " Map `gh` to hide dot-prefixed files.  Press `R` to "toggle" (reload).
            au FileType dirvish nnoremap <silent><buffer> gh :silent keeppatterns g@\v/\.[^\/]+/?$@d _<cr>:setl cole=3<cr>

            " Delete file
            au FileType dirvish nmap <silent><buffer> D :Shdo rm -rf {}<cr> Z! <cr>

            au FileType dirvish nmap <silent><nowait><buffer> q <Plug>(dirvish_quit)
        augroup END

    else
        fun! NetrwNerdtree()
            let g:netrw_liststyle=3

            execute "Lexplore "
            wincmd H

            execute "vertical resize 45"
        endf

        function! NetrwOpen(pane)
            let g:netrw_liststyle=0

            if a:pane == "split"
                execute "Sexplore "
            elseif a:pane == "vsplit"
                execute "Sexplore! "
            else
                execute "Explore "
            endif
        endfunction

        augroup netrwsettings
            autocmd!
            autocmd FileType netrw call s:netrw_maps()
        augroup END

        function! s:netrw_maps() abort
            if !exists(':TmuxNavigatorProcessList')
                nmap <buffer> <C-k> <C-w>k
                nmap <buffer> <C-j> <C-w>j
                nmap <buffer> <C-h> <C-w>h
                nmap <buffer> <C-l> <C-w>l
            else
                nmap <buffer> <silent> <C-h> :TmuxNavigateLeft<cr>
                nmap <buffer> <silent> <C-j> :TmuxNavigateDown<cr>
                nmap <buffer> <silent> <C-k> :TmuxNavigateUp<cr>
                nmap <buffer> <silent> <C-L> :TmuxNavigateRight<cr>
            endif
            nmap <buffer> gr <Plug>NetrwRefresh
            nmap <buffer> gh <Plug>NetrwHideEdit

            " 'h' & 'l' change directories except when in tree list mode
            if g:netrw_liststyle == 3
                nmap <buffer> h <Plug>NetrwLocalBrowseCheck
                nmap <buffer> l <Plug>NetrwLocalBrowseCheck
            else
                nmap <buffer> h <Plug>NetrwBrowseUpDir
                nmap <buffer> l <Plug>NetrwLocalBrowseCheck
            endif
        endfunction

        " hide banner and '.' in netrw
        let g:netrw_banner = 0
        let g:netrw_list_hide = '^\./$'
        let g:netrw_hide = 1

        " open netrw like nerdtree in tree mode
        noremap <silent> - :call NetrwNerdtree()<cr>

        " open netrw split horizontally and vertically from the curent pane
        noremap <silent> <leader>s :call NetrwOpen("split")<cr>
        noremap <silent> <leader>v :call NetrwOpen("vsplit")<cr>
    endif
endfunction

"noremap <leader>t :NERDTreeToggle<CR>
noremap <silent> <leader>e :call NerdTreeSync(":NERDTreeToggle")<cr>
" silent! map <F2> :NERDTreeFind<CR>
" noremap <silent> <leader>E :call NerdTreeSync(":NERDTreeTabsToggle")<cr>

augroup nerdtreeSettings
    autocmd!
    " Go up / enter directory easily
    au FileType nerdtree nmap <silent><buffer> l :call nerdtree#ui_glue#invokeKeyMap(g:NERDTreeMapActivateNode)<CR>
    au FileType nerdtree nmap <silent><buffer> h :call nerdtree#ui_glue#invokeKeyMap(g:NERDTreeMapActivateNode)<CR>
    
    " Open selected file in split/vertical split using <C-s>/<C-v>
    au FileType nerdtree nmap <silent><buffer> <C-s> :call nerdtree#ui_glue#invokeKeyMap("i")<CR>
    au FileType nerdtree nmap <silent><buffer> <C-v> :call nerdtree#ui_glue#invokeKeyMap("s")<CR>

    " Move between git changes (modified) with ]h/[h (nerdtree-git-plugin)
    au FileType nerdtree nmap <silent><buffer> [h :call nerdtree#ui_glue#invokeKeyMap("[c")<CR>
    au FileType nerdtree nmap <silent><buffer> ]h :call nerdtree#ui_glue#invokeKeyMap("]c")<CR>
augroup END

let g:nerdtree_tabs_open_on_console_startup=2
let g:nerdtree_tabs_open_on_gui_startup=2
let g:NERDTreeHijackNetrw = 0 

" Nerd Tree pake icon folder dari NerdFonts
" let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:nerdtree_tabs_startup_cd = 1  
let NERDTreeMinimalUI = 1
let NERDTreeChDirMode = 2

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
" let g:winresizer_start_key = '<C-w>r'
noremap <silent> <C-w>r :WinResizerStartResize<cr>
let g:winresizer_finish_with_escape = 1

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
" nmap gcy <plug>NERDCommenterYank |" copy (Yank) baris lalu comment
nmap gcy yygcc
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

if exists(':Files')
    let g:fzf_action = {
                \ 'Ctrl-t': 'tab split',
                \ 'Ctrl-s': 'split',
                \ 'Ctrl-v': 'vsplit' }

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
    " let $FZF_DEFAULT_OPTS="--no-mouse --height 70% -1 --reverse --inline-info --color=dark,bg:8 --bind ctrl-g:toggle-preview"

    if has('nvim-0.4.0')
        let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Normal', 'rounded': v:false } }
    endif
endif

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
let g:yoinkMoveCursorToEndOfPaste = 1

" vim-subversive
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)

" vim-subversive in visual mode
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
" let g:mkdp_browser = 'min'
let g:mkdp_browser = 'qutebrowser'
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 0
au Filetype markdown noremap <leader>p :MarkdownPreview<cr>

" Goyo & Limelight
noremap <silent> <A-g> :Goyo<cr>
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" CoC
au VimEnter * call Load_Coc()
function! Load_Coc()
    if exists(':CocCommand')
        let g:coc_global_extensions = ["coc-yank",
                    \ "coc-snippets",
                    \ "coc-explorer",
                    \ "coc-prettier",
                    \ "coc-highlight",
                    \ "coc-pairs",
                    \ "coc-git",
                    \ "coc-eslint",
                    \ "coc-emmet",
                    \ "coc-phpls",
                    \ "coc-json",
                    \ "coc-html",
                    \ "coc-flutter",
                    \ "coc-sql",
                    \ "coc-sh",
                    \ "coc-python",
                    \ "coc-java"]

        " filetype yang akan di deteksi oleh coc (javascriptreact = javascript)
        let g:coc_filetype_map = {
                    \ 'smarty': 'html',
                    \ 'blade': 'html',
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
        " inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
        if has('patch8.1.1068')
            " Use `complete_info` if your (Neo)Vim version supports it.
            inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
        else
            imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
        endif
        inoremap <silent><expr> <c-space> coc#refresh()

        " loncat diagnostic coc
        noremap <silent> [c <Plug>(coc-diagnostic-prev)
        noremap <silent> ]c <Plug>(coc-diagnostic-next)

        " Coc go-to definition/type/implementation/references
        nmap <silent> <leader>cd <Plug>(coc-definition)
        nmap <silent> <leader>ct <Plug>(coc-type-definition)
        nmap <silent> <leader>ci <Plug>(coc-implementation)
        nmap <silent> <leader>cr <Plug>(coc-references)

        " Rename symbol
        nmap <silent> <leader>cR <Plug>(coc-rename)

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

        " Coc-Flutter
        au Filetype dart command! Flutter CocList --input=flutter commands
    endif
endfunction
" markdown code fence language alias
let g:vim_markdown_fenced_languages = ['js=javascript','bash=sh']
" let g:vim_markdown_folding_style_pythonic = 1

" vim-rest-console
if !empty(glob(pluginsDir . '/vim-rest-console'))
    let g:vrc_trigger = '<cr>'
    let g:vrc_output_buffer_name = '__VRC_OUTPUT.json'
    let b:vrc_response_default_content_type = 'application/json'
    let g:vrc_curl_opts = {
                \ '-Ss': '',
                \}
    " let g:vrc_set_default_mapping = 0

    function! Load_and_format_Coc()
        call plug#load('coc.nvim')
        call CocAction('format')

    endfunction

    augroup restmaps
        autocmd!
        " au Filetype rest noremap <Cr> :call VrcQuery()<cr> <C-w>l

        au BufRead,BufNewFile,BufEnter,BufWinEnter,WinNew,WinEnter,SessionLoadPost  *__VRC_OUTPUT.json* set ma
        au BufRead,BufNewFile,BufEnter,BufWinEnter,WinNew,WinEnter,SessionLoadPost *__VRC_OUTPUT.json* set ft=json

        if exists(':CocAction')
            au Filetype rest call plug#load('coc.nvim')
            au BufRead,BufNewFile,BufEnter,BufWinEnter *__VRC_OUTPUT.json* call CocAction('format')
        endif
    augroup END
endif

let g:git_messenger_include_diff = "current"
let g:git_messenger_always_into_popup = v:true

function! Setup_git_messenger_popup() abort

    " set go back/forward history to <C-p>/<C-n>
    nmap <buffer><C-p> o
    nmap <buffer><C-n> O
endfunction
autocmd FileType gitmessengerpopup call Setup_git_messenger_popup()

" Bookmark buat plugin vim-startify
let g:startify_bookmarks = [ {'v': '$DOTFILES/.config/nvim/init.vim'},
			   \ {'x': '$DOTFILES/.Xresources'},
			   \ {'i': '$DOTFILES/.i3/config'},
			   \ {'n': '$NOTES/index.md'},
               \ {'t': '$DOTFILES/.tmux.conf'},
			   \ {'z': '$DOTFILES/.zshrc'},
               \ {'r': '~/.config/nvim/restapi'},
               \ {'d': '~/database.sql'} ]

let g:startify_change_to_dir = 1 " Ganti ke directory setiap buka file dengan startify
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

let g:sw_exe = '/usr/share/java/sqlworkbenchj/sqlwbconsole.sh'
" let g:sw_cache = '/.cache/sw'
let g:sw_highlight_resultsets = 0
let g:sw_command_timer = 1


augroup sw_maps
    autocmd!

    au BufRead,BufNewFile,BufEnter,BufWinEnter,WinNew,WinEnter,SessionLoadPost *__SQLResult__* set ft=sql

    " nnoremap <leader>dn :SWSqlBufferConnect .sql <Left><Left><Left><Left><Left>
    nnoremap <leader>dn :call Database_New()<cr>
    au Filetype sql nnoremap <Leader>ds :SWSqlBufferShareConnection 

    " Clear Output buffer
    au Filetype sql nnoremap <Leader>dw :SWSqlWipeoutResultsSets<cr> :echo output window cleared!<cr>

    " Find Object
    au Filetype sql nnoremap <Leader>df :SWSearchObject 
    au Filetype sql nnoremap <Leader>daf :SWSearchObjectAdvanced<cr>
    au Filetype sql nnoremap <F4> :SWSqlObjectInfo<cr>
    au Filetype sql nnoremap <Leader><F4> :SWSqlObjectSource<cr>

    " Echo out current connection
    au Filetype sql nnoremap <Leader><F1> :echo(sw#server#get_buffer_url(bufname('%')))<cr> 

    " Open database connection on newtab with connections list
    function! Database_New()
        let buffname = input("Pilih nama buffer untuk koneksi database: ", "")
        let buffname = buffname. ".sql"
        execute "tabnew" | Bdelete
        execute "SWSqlBufferConnect " . buffname | r ~/database.sql
    endfunction
augroup END
