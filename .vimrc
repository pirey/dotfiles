" This is my personal vimrc 
" The idea is to make it as simple as possible while covering all my needs
" See the repo at https://github.com/yeripratama/dotfiles

" NOTE: Press <space> to open/close folds

" General {{{

if !has('nvim')
    set encoding=utf-8
endif

set fileencoding=utf-8
set smartcase
set noswapfile
set hidden
set autoread
set nocursorcolumn
set nocursorline
set noerrorbells
set novisualbell
set backspace=indent,eol,start " normalize backspace behaviour

" Limit syntax highlighting
autocmd BufEnter * :syn sync maxlines=500
syntax sync minlines=256
syntax sync maxlines=256
set synmaxcol=250

" }}}

" Mapping {{{

let mapleader = ","

" I press :q! a lot, and mistyped
cnoremap Q q

nnoremap ; :
vnoremap ; :

" Save a file as sudo when we forgot to start vim using sudo.
nnoremap <leader>suw :w !sudo tee > /dev/null %<CR>

" Edit vimrc
nnoremap <leader>v :e ~/.vimrc<CR>
nnoremap <leader>ep :e ~/.vimrc.bundles<CR>

" Edit zshrc
nnoremap <leader>z :e ~/.zshrc<CR>

" reload vimrc
nnoremap <leader><leader>v :source ~/.vimrc<CR>

" Close current window
nnoremap <leader>w <C-w>c

" Open previous buffer
nnoremap <leader>b :b#<CR>

" Force close all buffers, clean things up!
nnoremap <leader><leader>bd :bufdo bd!<CR>

" Command line
cnoremap <c-n>  <down>
cnoremap <c-p>  <up>

" Paste copied text (with y)  in command line
cnoremap <c-v> <c-r>"

" Shell
" Jump to the main session in tmux
nnoremap <silent> <leader><leader>1 :!tmux switch -t MAIN<CR>

" }}}

" UI {{{

set number                  " show line numbers
set norelativenumber        " use no relative numbering.
set showcmd                 " show command in bottom bar
set showmode                " show current mode (insert, visual, bla bla)
set wildmenu                " visual autocomplete in command mode
set formatoptions-=cro      " disable auto comment
set nowrap                  " don't wrap line, let them flow..
set diffopt +=vertical      " open diffs in vertical split.
set splitright              " open new vsplit to the right
set listchars=tab:▸\ ,eol:¬
" Make the vertical split separator looks simpler
autocmd ColorScheme * hi VertSplit ctermbg=NONE guibg=NONE
hi VertSplit ctermbg=NONE guibg=NONE
" toggle list
nnoremap <leader>l :set list!<CR>
" toggle relative numbering
nnoremap <C-n> :set relativenumber!<CR>
" toggle highlight current line
nnoremap <leader>hx :set cursorline!<CR>
" toggle highlight current column
nnoremap <leader>hy :set cursorcolumn!<CR>
"filetype indent on " load filetype-specific indent files
"set lazyredraw 
"set showmatch " highlight matching [{()}]

" Statusline
set laststatus=2 " always show statusline
set statusline=%<%t\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set showtabline=0

" }}}

" Colors {{{

syntax enable " enable syntax processing
set background=dark
"set t_Co=256 " set terminal color to use 256

" Enable transparent background
"hi Normal ctermbg=NONE

" Gruvbox
"silent! colorscheme gruvbox
" gruvbox use italic font for commented lines,
" and sometimes the background color becomes incorrect
let  g:gruvbox_italic = 0

" Solarized
let g:solarized_termtrans=1 " enable transparent bg
silent! colorscheme solarized

" Toggle background
" http://tilvim.com/2013/07/31/swapping-bg.html
map <Leader><leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>

" }}}

" Space - Tab - Indent {{{

set tabstop=4     " tab width
set softtabstop=4 " show existing tab with 4 spaces width
set shiftwidth=4  " when indenting with '>', use 4 spaces width
set expandtab     " when we press tab, tell vim to insert 4 spaces instead
set breakindent   " indent wrapped lines

" }}}

" Searching {{{

set ignorecase " be case insensitive
set gdefault   " turn on regex's global option by default
set incsearch  " instant search, search as we type
set hlsearch   " highlight matches
" in visual mode, press // to search for selected text
vnoremap // y/<C-R>"<CR> 

" Better cursor position
nnoremap n nzz
nnoremap N Nzz

if executable('ag')
  " Use Ag over Grep or Ack, highly recommended!
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
" removes underline in fold text
hi Folded term=NONE cterm=NONE
" open or close a fold
nnoremap <space> za 

autocmd FileType vim setlocal foldmethod=marker

function! NeatFoldText() " {{{
   let line = getline(v:foldstart)

   let nucolwidth = &fdc + &number * &numberwidth
   let windowwidth = winwidth(0) - nucolwidth - 3
   let foldedlinecount = v:foldend - v:foldstart

   " expand tabs into spaces
   let onetab = strpart('          ', 0, &tabstop)
   let line = substitute(line, '\t', onetab, 'g')

   let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
   let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
   return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}

set foldtext=NeatFoldText()

" }}}

" Movement {{{
set scrolloff=1 " Show n lines after / before scrolling
set scrolloff=1 " Show 1 lines after / before scrolling

" faster horizontal scroll
nnoremap zh 20zh
nnoremap zl 20zl

" normalize up and down movement in wrapped line
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Now, this is my favorite part, jumping like a Ninja!

" jump to the left and right
nnoremap E 20l
nnoremap B 20h
vnoremap E 20l
vnoremap B 20h

" Semi soft scroll, scroll half the page
" nnoremap J <C-d>
" nnoremap K <C-u>
" vnoremap J <C-d>
" vnoremap K <C-u>

" Soft scroll, scroll 10 lines
nnoremap J 10gj
nnoremap K 10gk
vnoremap J 10gj
vnoremap K 10gk

" Easier window movement, you'll love this soon or later!
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Some mapping from tpope's unimpaired
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :cfirst<CR>
nnoremap ]Q :clast<CR>
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>
nnoremap [B :bfirst<CR>
nnoremap ]B :blast<CR>


" }}}

" Clipboard {{{

if has('clipboard')

    " Only enable mouse when vim has clipboard support
    if has('mouse')
        set mouse=a
    endif

    " Use ctrl-c to copy selected text to clipboard
    vmap <C-c> "+y
endif
set pastetoggle=<leader>p

" }}}

" GUI / Mac Vim / Neovim {{{

if has('gui_running')
    silent! colorscheme gruvbox

    set guioptions-=m " remove menu bar
    set guioptions-=T " remove toolbar
    set guioptions-=L " remove left scroll bar
    "set cursorline
end

" Macvim
if has('gui_macvim')
    set transparency=1
endif

" Neovim
if !has('nvim')
    set ttymouse=xterm2

else
    if has('mac')
        let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
    endif
endif

" }}}

" Custom {{{

" Load global custom configuration if exists
"if filereadable(expand("~/.vimrc.custom"))
    "source ~/.vimrc.custom
"endif

" }}}

" Plugin {{{

" Separate plugin configuration with main vimrc
" I can try & use different plugin manager without messing with current setting
source ~/.vimrc.bundles

" }}}

" ETC {{{
set secure
" }}}
