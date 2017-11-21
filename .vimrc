" This is my personal vimrc
" The idea is to make it as simple as possible while covering all my needs
" See the repo at https://github.com/pirey/dotfiles

" Name:     .vimrc
" Author:   Yeri <arifyeripratama@gmail.com>
" URL:      https://github.com/pirey/dotfiles
" License:  MIT license
" Created:  2015
" Modified: Frequently
" NOTE:     Press <space> to open/close folds

" TODO: better config type organization

" General {{{

if !has('nvim')
    set encoding=utf-8
endif

set fileencoding=utf-8
set noswapfile
set hidden
set autoread
set nocursorcolumn
set nocursorline
set noerrorbells
set novisualbell
set backspace=indent,eol,start " normalize backspace behaviour

" Limit syntax highlighting
"autocmd BufEnter * :syn sync maxlines=500
syntax sync minlines=256
syntax sync maxlines=256
set synmaxcol=250

" don't load matchparen plugin (builtin plugin)
" boost performance when folding text
"let loaded_matchparen = 1
"set noshowmatch

" set timeout for match paren computation
let g:matchparen_timeout = 20
let g:matchparen_insert_timeout = 20

" }}}

" Mapping {{{

let mapleader = ","

" I press :q! a lot, and mistyped
"cnoremap Q q

nnoremap ; :
vnoremap ; :

" Save a file as sudo when we forgot to start vim using sudo.
nnoremap <leader>suw :w !sudo tee > /dev/null %<CR>

" Edit vimrc
nnoremap <leader>v :e ~/.vimrc<CR>
nnoremap <leader>ep :e ~/.pluginconfig.vim<CR>

" reload vimrc
nnoremap <leader><leader>v :source ~/.vimrc<CR>

" Close current window
nnoremap <leader>w <C-w>c

" Open previous buffer
nnoremap <leader>b :b#<CR>

" Close current buffer, this will be improved by plugin called Bclose
nnoremap <leader>x :bd!<CR>
" Force close all buffers, clean things up!
nnoremap <leader><leader>x :bufdo bd!<CR>

" Command line
cnoremap <c-n>  <down>
cnoremap <c-p>  <up>

" Paste copied text (with y)  in command line
cnoremap <c-v> <c-r>"

" Shell

" select last pasted text
nnoremap gp `[v`]
nnoremap yp yyp
nnoremap yP yyP

" auto indent pasted text
" TODO disable auto indent only on html files
"nnoremap p p=`]
"nnoremap P P=`]

" go to end of line, but not really
vnoremap $ $h

" }}}

" Variables {{{
" set this variable to 1 in .pluginconfig.vim to custom the statusline
" e.g use vim-airline or just add fugitive git branch name
let g:statusline_set = 0
" }}}

" Plugin {{{

" Separate plugin configuration with main vimrc
" I can try & use different plugin manager without messing with current setting
source ~/.pluginconfig.vim

" }}}

" Colors & Highlighting {{{

syntax enable " enable syntax processing
set background=dark
silent! colorscheme solarized
set t_Co=256 " set terminal color to use 256
if !has('gui_running')
    set term=screen-256color
endif

" Gruvbox
" gruvbox use italic font for commented lines,
" and sometimes the background color becomes incorrect
let  g:gruvbox_italic = 0

" Toggle background
" http://tilvim.com/2013/07/31/swapping-bg.html
map <Leader><leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>

" transparent background
hi Normal ctermbg=8
" hides tildes
hi NonText ctermfg=8
" hides line number, but keep padding
hi LineNr ctermfg=8 ctermbg=8
" soft visual selection
hi Visual cterm=NONE ctermbg=0 ctermfg=NONE
hi SignColumn guibg=NONE

" }}}

" UI {{{

set nonumber                " don't really need line numbers
set norelativenumber        " use no relative numbering.
set showcmd                 " show command in bottom bar
set showmode                " show current mode (insert, visual, bla bla)
set wildmenu                " visual autocomplete in command mode
set formatoptions-=cro      " disable auto comment
set nowrap                  " don't wrap line, let them flow..
set diffopt +=vertical      " open diffs in vertical split.
set splitright              " open new vsplit to the right
set signcolumn=yes          " enable sign gutter by default
set listchars=tab:▸\ ,eol:¬
" Make the vertical split separator looks simpler
set fillchars+=vert:\ " replace separator with whitespace
autocmd ColorScheme * hi VertSplit cterm=NONE ctermbg=8 guibg=NONE
hi VertSplit cterm=NONE ctermbg=8 guibg=NONE
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
set showmatch " highlight matching [{()}]

" Statusline
set laststatus=2 " always show statusline
" set statusline if not yet set in plugin configuration
if (g:statusline_set < 1)
    set statusline=\(%{toupper(mode())}\)\ %<%t\ %h%m%r%=%-14.(%l,%c%V%)\ %P
endif
set showtabline=0
" only show statusline for active buffer
hi clear StatusLineNC
hi StatusLineNC ctermfg=8 ctermbg=8
hi StatusLine ctermfg=2

" }}}

" Space - Tab - Indent {{{

"set tabstop=4     " tab width
"set softtabstop=4 " show existing tab with 4 spaces width
"set shiftwidth=4  " when indenting with '>', use 4 spaces width
set tabstop=4      " tab width
set shiftwidth=0   " Make 'shiftwidth' follow 'tabstop'
set softtabstop=-1 " Make 'softtabstop' follow 'shiftwidth'
set expandtab      " when we press tab, tell vim to insert 4 spaces instead
if has('linebreak')
    set breakindent   " indent wrapped lines
endif

" }}}

" Searching {{{

set ignorecase " be case insensitive
set smartcase  " be case sensitive when search pattern contains uppercase character
set gdefault   " turn on regex's global option by default
set incsearch  " instant search, search as we type
set hlsearch   " highlight matches
" in visual mode, press * to search for selected text, instead of jumping the
" selection
vnoremap * y/<C-R>"<CR>
" auto turn off previous highlight when searching
nnoremap / :noh<cr>/

" auto center search item
nnoremap n nzz
nnoremap N Nzz

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

" search in selection
function! RangeSearch(direction)
    call inputsave()
    let g:srchstr = input(a:direction)
    call inputrestore()
    if strlen(g:srchstr) > 0
        let g:srchstr = g:srchstr.
                    \ '\%>'.(line("'<")-1).'l'.
                    \ '\%<'.(line("'>")+1).'l'
    else
        let g:srchstr = ''
    endif
endfunction
vnoremap <silent> / :<C-U>call RangeSearch('/')<CR>:if strlen(g:srchstr) > 0\|exec '/'.g:srchstr\|endif<CR>
vnoremap <silent> ? :<C-U>call RangeSearch('?')<CR>:if strlen(g:srchstr) > 0\|exec '?'.g:srchstr\|endif<CR>

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

" Easier window movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <C-w>f <C-w>vgf
nnoremap <C-w>f <C-w>vgf
nnoremap <C-w><c-f> <C-w>vgf

" }}}

" Clipboard {{{

if has('clipboard')

    " Only enable mouse when vim has clipboard support
    " otherwise we will get hard time copying stuff to the clipboard
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
    set guioptions-=m " remove menu bar
    set guioptions-=T " remove toolbar
    set guioptions-=L " remove left scroll bar
    set guioptions-=r " remove right scroll bar
    "set cursorline
end

" Macvim
if has('gui_macvim')
    set transparency=1
    set guifont=Menlo:h12
endif

" Neovim
if !has('nvim')
    set ttymouse=xterm2

    " cursor shape
    if exists('$TMUX')
        let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    else
        let &t_SI = "\<Esc>]50;CursorShape=1\x7"
        let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    endif

    " eliminate escape delay
    set timeoutlen=1000 ttimeoutlen=0

else
    if has('mac')
        " change cursor shape
        let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
    endif
endif

" }}}

" ETC {{{
" have no idea what this thing's doing
" put it anyway
set secure
" silent! colorscheme nord
" hi clear VertSplit
" hi VertSplit ctermfg=8
" hi clear StatusLineNC
" hi StatusLineNC ctermfg=8
" hi clear StatusLine
" hi StatusLine ctermfg=0 ctermbg=2
" }}}
