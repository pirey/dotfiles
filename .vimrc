" This is my personal vimrc ( https://github.com/yeripratama/dotfiles )

" Press <space> to open/close folds

" General {{{

set fileencoding=utf-8
set smartcase
set noswapfile
set hidden
set autoread " auto reload if a file modified outside vim
set nocursorcolumn
set nocursorline

" Limit syntax highlighting
autocmd BufEnter * :syn sync maxlines=500
syntax sync minlines=256
syntax sync maxlines=256
set synmaxcol=800

" }}}

" Mapping {{{

let mapleader = ","

nnoremap ; :
vnoremap ; :

" Allow saving of files as sudo when I forgot to start vim using sudo.
nnoremap <leader>suw :w !sudo tee > /dev/null %<CR>

" Edit vimrc
nnoremap <leader>v :e ~/.vimrc<CR>

" Edit zshrc
nnoremap <leader>z :e ~/.zshrc<CR>

" reload vimrc
nnoremap <leader><leader>v :source ~/.vimrc<CR>

" Easier window movement
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Close current window
nnoremap <leader>w <C-w>c

" Open previously open buffer
nnoremap <leader>b :b#<CR>

" Force close all buffers
nnoremap <leader><leader>bd :bufdo bd!<CR>

" Some mapping from tpope's unimpaired
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :cfirst<CR>
nnoremap ]Q :clast<CR>
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>
nnoremap [B :bfirst<CR>
nnoremap ]B :blast<CR>

" Command line
cnoremap <c-n>  <down>
cnoremap <c-p>  <up>

" Paste yanked text in command line
cnoremap <c-v> <c-r>"

" }}}

" Colors {{{

syntax enable " enable syntax processing
set background=dark
set t_Co=256 " set terminal color to use 256

" fixing incorrect background when displaying italic fonts
let  g:gruvbox_italic = 0

" Enable transparent background
hi Normal ctermbg=NONE

" Gruvbox
silent! colorscheme gruvbox

" Solarized
let g:solarized_termtrans=1
silent! colorscheme solarized

" Toggle background
" http://tilvim.com/2013/07/31/swapping-bg.html
map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>

" }}}

" Space - Tab {{{

set tabstop=4 " tab width
set softtabstop=4 " show existing tab with 4 spaces width
set shiftwidth=4 " when indenting with '>', use 4 spaces width
set expandtab " On pressing tab, insert 4 spaces
set backspace=indent,eol,start " backspace hapus tab, end of line, start line

" }}}

" UI {{{

set number                  " show line numbers
set norelativenumber        " default use no relative numbering.
set showcmd                 " show command in bottom bar
set showmode
set wildmenu                " visual autocomplete for command menu
set formatoptions-=cro      " disable auto comment
set nowrap                  " nowrap line
set diffopt +=vertical      " open diffs in vertical split.
set listchars=tab:▸\ ,eol:¬
set splitright              " open new vsplit to the right
hi VertSplit ctermbg=NONE
" toggle list
nnoremap <leader>l :set list!<CR>
" toggle relative numbering
nnoremap <C-n> :set relativenumber!<CR>
" toggle highlight current line
nnoremap <leader>hx :set cursorline!<CR>
" toggle highlight current column
nnoremap <leader>hy :set cursorcolumn!<CR>
"filetype indent on " load filetype-specific indent files
"set lazyredraw " redraw only when we need to.
"set showmatch " highlight matching [{()}]

" Status Line: {{{
set statusline=%f%m
set statusline+=%=
" }}}

" }}}

" Searching {{{

set ignorecase " be case insensitive
set gdefault   " always turn on global regex
set incsearch  " search as characters are entered
set hlsearch   " highlight matches
" set visually selected text as search param
vnoremap // y/<C-R>"<CR> 

" Better cursor position
nnoremap n nzz
nnoremap N Nzz

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

" }}}

" Folding {{{

set foldenable " enable folding
set foldlevelstart=10 " open most folds by default
set foldnestmax=10 " 10 nested fold max
set foldmethod=indent " fold based on indent level
" space open/close folds
nnoremap <space> za 

augroup VimFdm
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

function! NeatFoldText()
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()

" }}}

" Movement {{{

set scrolloff=1 " Show n lines after / before scrolling
set scrolloff=1 " Show 1 lines after / before scrolling

" easier navigation to beginning/end of line
nnoremap E $
nnoremap B ^

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" easy scroll
nnoremap <S-j> <C-d>
nnoremap <S-k> <C-u>

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

    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    set guioptions-=L "remove left scroll bar
    set cursorline
end

" Macvim
if has('gui_macvim')
    set transparency=1
endif

" Neovim
if !has('nvim')
    set encoding=utf-8
    set ttymouse=xterm2
endif

" }}}

" Custom {{{

" Load global custom configuration if exists

if filereadable(expand("~/.vimrc.custom"))
    source ~/.vimrc.custom
endif

" Load local (per project) custom configuration if exists

if filereadable(expand(".vimrc.local"))
    source .vimrc.local
endif

" }}}

" Plugin {{{

if ! exists('LITE_MODE')
    if filereadable(expand('~/.vimrc.bundles'))
        source ~/.vimrc.bundles
    endif
endif

" }}}

" ETC {{{
"
" }}}
