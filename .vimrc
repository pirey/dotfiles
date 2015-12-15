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
Plugin 'Solarized'
Plugin 'ctrlp.vim'
Plugin 'EasyMotion'
Plugin 'The-NERD-tree'

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

"Colors
syntax enable " enable syntax processing
set background=dark
let g:solarized_termcolors=256
"colorscheme solarized
colorscheme hybrid

"Space & Tabs
set tabstop=4 " number of visual spaces per TABj
set softtabstop=4 " number of spaces in tab when editing

"UI Config
set number " show line numbers
set showcmd " show command in bottom bar
set cursorline " highlight current line
filetype indent on " load filetype-specific indent files
set wildmenu " visual autocomplete for command menu
set lazyredraw " redraw only when we need to.
set showmatch " highlight matching [{()}]
set formatoptions-=cro " disable auto comment

"Searching
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

"Movement
" move vertically by visual line
nnoremap j gj
nnoremap k gk

"My Remap
" shortcut for editing this .vimrc
nnoremap <leader>v :e ~/.vimrc<CR>
" shortcut for reload .vimrc
nnoremap <leader><leader>v :w<CR>:source ~/.vimrc<CR>
