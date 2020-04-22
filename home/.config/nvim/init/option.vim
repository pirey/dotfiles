" General {{{

if !has('nvim')
    set encoding=utf-8
endif

set fileencoding=utf-8
" set confirm
set noswapfile
set hidden
set autoread
set nocursorcolumn
set nocursorline
set noerrorbells
set novisualbell
set backspace=indent,eol,start " normalize backspace behaviour
set ttimeoutlen=10

" Limit syntax highlighting
"autocmd BufEnter * :syn sync maxlines=500
syntax sync minlines=256
syntax sync maxlines=256
set synmaxcol=250

" set timeout for match paren computation
set showmatch " highlight matching [{()}]
let g:matchparen_timeout = 20
let g:matchparen_insert_timeout = 20

" }}}

" Colors {{{

syntax enable " enable syntax processing
set background=dark
set t_Co=256
if !has('gui_running')
    if !has('nvim')
        set term=screen-256color
    endif
endif

" }}}

" UI {{{

set nonumber                " don't really need line numbers
set ruler                   " number and colon in bottom right
set norelativenumber        " use no relative numbering.
set showcmd                 " show command in bottom bar
set noshowmode              " don't show current mode (insert, visual, bla bla)
set wildmenu                " visual autocomplete in command mode
set formatoptions-=cro      " disable auto comment
set nowrap                  " don't wrap line, let them flow..
set diffopt+=vertical      " open diffs in vertical split.
set splitright              " open new vsplit to the right
set signcolumn=yes          " enable sign gutter by default
set listchars=tab:▸\ ,eol:¬
set nolist                  " do not show listchars
" Make the vertical split separator 'disappear'
" set fillchars+=vert:\ " replace separator with whitespace
set fillchars+=vert:\⎟
if has('linebreak')
    set breakindent   " indent wrapped lines
endif
"filetype indent on " load filetype-specific indent files
"set lazyredraw

" Statusline
set laststatus=2
set showtabline=0

" }}}

" Space - Tab - Indent {{{

set tabstop=2     " tab width
set softtabstop=2 " show existing tab with 4 spaces width
set shiftwidth=2  " when indenting with '>', use 4 spaces width
set expandtab      " when we press tab, tell vim to insert 4 spaces instead

" }}}

" Searching {{{

set ignorecase " be case insensitive
set smartcase  " be case sensitive when search pattern contains uppercase character
set gdefault   " turn on regex's global option by default
set incsearch  " instant search, search as we type
set hlsearch   " highlight matches

" Determine grep tool to be used
if executable('rg')
    " Use RipGrep over Ag, Grep or Ack
    " They said this is the fastest
    set grepprg=rg\ --no-heading\ --vimgrep
elseif executable('ag')
    " Use Ag over Grep or Ack
    set grepprg=ag\ --nogroup\ --nocolor
else
    if executable('ack')
        " Use Ack over Grep
        set grepprg=ack\ --nogroup\ --nocolor
    elseif executable('ack-grep')
        set grepprg=ack-grep\ --nogroup\ --nocolor
    endif
endif

" }}}

" Folding {{{
set foldenable        " enable folding
set foldlevelstart=10 " open most folds by default
set foldnestmax=10    " 10 nested fold max
set foldmethod=indent " fold based on indent level

augroup vim_fold
    autocmd!
    autocmd FileType vim,tmux,conf,rest setlocal foldmethod=marker
augroup END

" }}}

" Movement {{{
set scrolloff=1 " Show n lines after / before scrolling
set scrolloff=1 " Show 1 lines after / before scrolling
" }}}

" colorscheme {{{

" use colorscheme config helper from base16 shell
if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif

" colo nord

" }}}
