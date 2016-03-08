"    ________ ______  __________ _   _________    _   ________  ___
"   /_  __/ // / __/ / __/  _/ /| | / / __/ _ \  | | / /  _/  |/  /
"    / / / _  / _/  _\ \_/ // /_| |/ / _// , _/  | |/ // // /|_/ / 
"   /_/ /_//_/___/ /___/___/____/___/___/_/|_|   |___/___/_/  /_/  
                                                                            
" Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Some cool plugins here
Plugin 'flazz/vim-colorschemes'            " All colorscheme
Plugin 'ctrlp.vim'                         " File searcher <c-p>
Plugin 'EasyMotion'                        " Jumping over places <leader><leader>w
Plugin 'The-NERD-tree'                     " File browser <leader>d
Plugin 'The-NERD-Commenter'                " Commenter `<leader>c<space>`
Plugin 'NERD_Tree-and-ack'                 " Find in folder, from nerdtree
Plugin 'fugitive.vim'                      " Git wrapper
Plugin 'airblade/vim-gitgutter'            " Git changes sign
Plugin 'SuperTab'                          " Auto complete <tab>
Plugin 'delimitMate.vim'                   " Auto add matching [({''})]
Plugin 'bling/vim-airline'                 " Statusline
Plugin 'vim-airline/vim-airline-themes'    " Themes for airline plugin
Plugin 'mattn/emmet-vim'                   " Emmet for vim `<c-y>,`
Plugin 'MatchTag'                          " Highlight matching html tag
Plugin 'BufOnly.vim'                       " Close all buffer but this one. :Bufonly
Plugin 'NrrwRgn'                           " Separate selected text and edit it to new window :NR
Plugin 'surround.vim'                      " Surrounder `cs*`
Plugin 'vim-utils/vim-man'                 " View other program's manual page in vim :Man
Plugin 'Tabular'                           " Aligning tool :Tabular /{pattern}
Plugin 'jeffkreeftmeijer/vim-numbertoggle' " Toggle number <c-n>
Plugin 'textutil.vim'                      " Open rtf, doc, rtfd, wordml as plain text (Mac only)
Plugin 'Tagbar'                            " List tags in sidebar

if executable('ack') || executable('ack-grep')
    " Better than grep, they said http://beyondgrep.com
    Plugin 'ack.vim'
endif

if executable('ag')
    " Seriously, use The Silver Searcher https://github.com/ggreer/the_silver_searcher
    Plugin 'rking/ag.vim' " Ag
endif


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Plugin configurations

" Tagbar
nnoremap <leader>t :TagbarToggle<CR>

" Git Gutter
let g:gitgutter_realtime = 0 " disable realtime update, in hope vim doesn't lag
let g:gitgutter_eager = 0
nnoremap <leader>g :GitGutterToggle<CR>
nnoremap <leader>G :GitGutterLineHighlightsToggle<CR>
" hunk stage = <leader>hs
" hunk revert stage (unstage) = <leader>hr

" Vim Airline
set laststatus=2 " always show statusline
let g:airline#extensions#tabline#enabled =1 " enable tabline
let g:airline#extensions#tabline#fnamemod = ':t' " show only the file name
" Use simple square shaped statusline rather than 'fancy' powerline
let g:airline_left_sep = ''
let g:airline_right_sep = ''
" Use this instead if you want to use powerline
"let g:airline_powerline_fonts = 1 

" NERDTree
nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <leader>D :NERDTreeFind<CR>

" Emmet-Vim, trigger pake ini <c-y>,

" Surround cheatsheet
" cs"'
" cs'<q>
" cst"
" ds"
" S<p class="something">

" CtrlP
" keep cache when reopen CtrlP, to refresh use <F5>
let g:ctrlp_clear_cache_on_exit = 0

" General Configurations

set encoding=utf-8
set fileencoding=utf-8
set smartcase
set noswapfile
set hidden

"Colors
syntax enable " enable syntax processing
set background=dark
set t_Co=256 " set terminal color to use 256
silent! colorscheme Tomorrow-Night " Chose this color if it's exists, surpress the error if it isn't
" Enable transparent background
hi Normal ctermbg=NONE
" Provide shortcut for solarized colorscheme, because why not?
nnoremap <leader><leader>bg :silent! colorscheme solarized<CR>

"Space & Tabs
set tabstop=4 " tab width
set softtabstop=4 " show existing tab with 4 spaces width
set shiftwidth=4 " when indenting with '>', use 4 spaces width
set expandtab " On pressing tab, insert 4 spaces
set backspace=indent,eol,start " backspace hapus tab, end of line, start line

"UI Config
set number " show line numbers
set norelativenumber " default use no relative numbering.
set showcmd " show command in bottom bar
set wildmenu " visual autocomplete for command menu
set formatoptions-=cro " disable auto comment
set nowrap " nowrap line
set diffopt +=vertical " open diffs in vertical split.
set listchars=tab:▸\ ,eol:¬
nnoremap <leader>l :set list!<CR>
"set cursorline " highlight current line
"filetype indent on " load filetype-specific indent files
"set lazyredraw " redraw only when we need to.
"set showmatch " highlight matching [{()}]


"Searching
set ignorecase " be case insensitive
set gdefault " always turn on global regex
set incsearch " search as characters are entered
set hlsearch " highlight matches
" set visually selected text as search param
vnoremap // y/<C-R>"<CR> 

if executable('ack')
  " Use Ack over Grep
  set grepprg=ack\ --nogroup\ --nocolor
elseif executable('ack-grep')
  set grepprg=ack-grep\ --nogroup\ --nocolor
endif

if executable('ag')
  " Use Ag over Grep or Ack
  set grepprg=ag\ --nogroup\ --nocolor
endif

"Folding
set foldenable " enable folding
set foldlevelstart=10 " open most folds by default
set foldnestmax=10 " 10 nested fold max
set foldmethod=indent " fold based on indent level
" space open/close folds
nnoremap <space> za 

"Movement and Scrolling
set scrolloff=1 " Show n lines after / before scrolling
set scrolloff=1 " Show 1 lines after / before scrolling
" move vertically by visual line
nnoremap j gj
nnoremap k gk
nmap <S-j> <C-d>
nmap <S-k> <C-u>

" General Shortcut & Mapping

nnoremap ; :

" Edit vimrc
nnoremap <leader>v :e ~/.vimrc<CR>

" Save vimrc
nnoremap <leader><leader>v :w<CR>:source ~/.vimrc<CR>

" Paste toggle
set pastetoggle=<leader>p

" Easier window movement
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
" Close current window
nnoremap <leader>w <C-w>c

" Buffers
set autoread " auto reload if a file modified outside vim

" Open previously open buffer
nnoremap <leader>b :b#<CR>

" Some mapping from tpope's unimpaired mapping
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :cfirst<CR>
nnoremap ]Q :clast<CR>
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>
nnoremap [B :bfirst<CR>
nnoremap ]B :blast<CR>

" Specific setting for gui vim
if has('gui_running')
    set transparency=10
    silent! colorscheme gruvbox
    " Font for macvim/gvim
    set guifont=Droid\ Sans\ Mono\ for\ Powerline

    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    set guioptions-=L "remove left scroll bar
end

" Performance issue improvement
" someday i run into a large file and my vim somehow went lagging,
" so this is what i found on the google
autocmd BufEnter * :syn sync maxlines=500
syntax sync minlines=100
syntax sync maxlines=240
set synmaxcol=800
set nocursorcolumn
set nocursorline
syntax sync minlines=256

" Local config
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif
