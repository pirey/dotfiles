"Vundle Config
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


" Add Plugins here..
Plugin 'Solarized' " you know it
Plugin 'ctrlp.vim' " similar to ctrl-p in sublime text
Plugin 'EasyMotion' " easy motion, use: \\w
Plugin 'mileszs/ack.vim' " Ack
Plugin 'The-NERD-tree' " file browser
Plugin 'The-NERD-Commenter' " commenter
Plugin 'NERD_Tree-and-ack' " nerdtree act, search pattern (pake quote)
Plugin 'fugitive.vim' " git wrapper
Plugin 'AutoClose' " auto add matching [({''})]
Plugin 'SuperTab' " auto complete
Plugin 'bling/vim-airline' " statusline
Plugin 'airblade/vim-gitgutter' "adds +, -, or ~ next to the line numbers.
Plugin 'scratch.vim' " open scratch file that will not be saved

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



"Etc
set fileencoding=utf-8
set ignorecase
set smartcase
set noswapfile

"Colors
syntax enable " enable syntax processing
set t_Co=256
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

"Space & Tabs
set tabstop=4 " show existing tab with 4 spaces width
set shiftwidth=4 " when indenting with '>', use 4 spaces width
set expandtab " On pressing tab, insert 4 spaces
set backspace=indent,eol,start " backspace hapus tab, end of line, start line

"UI Config
set number " show line numbers
set showcmd " show command in bottom bar
set cursorline " highlight current line
filetype indent on " load filetype-specific indent files
set wildmenu " visual autocomplete for command menu
set lazyredraw " redraw only when we need to.
set showmatch " highlight matching [{()}]
set formatoptions-=cro " disable auto comment
set nowrap " nowrap line

" Vim Airline
set laststatus=2 " always show statusline
let g:airline#extensions#tabline#enabled =1 " enable tabline
let g:airline_powerline_fonts = 1

" unicode symbols, pakai ini kalo belum punya patched font nya.
"if !exists('g:airline_symbols')
"let g:airline_symbols = {}
"endif
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.crypt = '🔒'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.space = "\ua0"
"let g:airline_symbols.whitespace = 'Ξ'

"NERDTree
nnoremap <leader>d :NERDTreeToggle<CR>

"Searching
set gdefault " always turn on global regex
set incsearch " search as characters are entered
set hlsearch " highlight matches
" set selected text as search param, use //
vnoremap // y/<C-R>"<CR> 

"Folding
set foldenable " enable folding
set foldlevelstart=10 " open most folds by default
set foldnestmax=10 " 10 nested fold max
nnoremap <space> za " space open/close folds
set foldmethod=indent " fold based on indent level

"Movement and Scrolling
" move vertically by visual line
nnoremap j gj
nnoremap k gk
nmap <S-j> <PageDown>
nmap <S-k> <PageUp>
set scrolloff=3 " Show 3 lines after / before scrolling

"My Remap
" Save file
nnoremap <leader>s :w<CR>

" Save file and quit
nnoremap <leader><leader>s :wq<CR>

" Edit vimrc
nnoremap <leader>v :e ~/.vimrc<CR>

" Save vimrc
nnoremap <leader><leader>v :w<CR>:source ~/.vimrc<CR>

" new tab
nnoremap <C-t> :tabe<CR>

" Paste toggle
set pastetoggle=<leader>p

" Permudah navigasi antar window
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nnoremap <leader>w <C-w>c
nnoremap <leader>W <C-w>o
