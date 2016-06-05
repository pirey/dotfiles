" This is my personal vimrc 
" The idea is to make it as simple as possible while covering all my needs
" See the repo at https://github.com/yeripratama/dotfiles

" NOTE: Press <space> to open/close folds

" General {{{

set fileencoding=utf-8
set smartcase
set noswapfile
set hidden
set autoread
set nocursorcolumn
set nocursorline
set noerrorbells
set novisualbell

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

" Allow saving of files as sudo when I forgot to start vim using sudo.
nnoremap <leader>suw :w !sudo tee > /dev/null %<CR>

" Edit vimrc
nnoremap <leader>v :e ~/.vimrc<CR>
nnoremap <leader>ep :e ~/.vimrc.bundles<CR>

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

" Shell
" Jump to the main session in tmux
nnoremap <silent> <leader><leader>1 :!tmux switch -t MAIN<CR>

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

set tabstop=4                  " tab width
set softtabstop=4              " show existing tab with 4 spaces width
set shiftwidth=4               " when indenting with '>', use 4 spaces width
set expandtab                  " On pressing tab, insert 4 spaces
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
" Make vertical split separator looks thinner
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
"set lazyredraw " redraw only when we need to.
"set showmatch " highlight matching [{()}]

" Statusline
set laststatus=2 " always show statusline
set statusline=%<%t\ %h%m%r%=%-14.(%l,%c%V%)\ %P

"" Status Line: {{{
"" https://github.com/blaenk/dots/blob/master/vim/.vimrc
"
"function! Status(winnum) " {{{
"    let active = a:winnum == winnr()
"    let bufnum = winbufnr(a:winnum)
"
"    let stat = ''
"
"    " this function just outputs the content colored by the
"    " supplied colorgroup number, e.g. num = 2 -> User2
"    " it only colors the input if the window is the currently
"    " focused one
"
"    function! Color(active, group, content)
"        if a:active
"            return '%#' . a:group . '#' . a:content . '%*'
"        else
"            return a:content
"        endif
"    endfunction
"
"    " this handles alternative statuslines
"    let usealt = 0
"
"    let type = getbufvar(bufnum, '&buftype')
"    let name = bufname(bufnum)
"
"    let altstat = ''
"
"    if type ==# 'help'
"        let altstat .= '%#SLHelp# HELP %* ' . fnamemodify(name, ':t:r')
"        let usealt = 1
"    elseif name ==# '__Gundo__'
"        let altstat .= ' Gundo'
"        let usealt = 1
"    elseif name ==# '__Gundo_Preview__'
"        let altstat .= ' Gundo Preview'
"        let usealt = 1
"    endif
"
"    if usealt
"        return altstat
"    endif
"
"    " column
"    "   this might seem a bit complicated but all it amounts to is
"    "   a calculation to see how much padding should be used for the
"    "   column number, so that it lines up nicely with the line numbers
"
"    "   an expression is needed because expressions are evaluated within
"    "   the context of the window for which the statusline is being prepared
"    "   this is crucial because the line and virtcol functions otherwise
"    "   operate on the currently focused window
"
"    function! Column()
"        let vc = virtcol('.')
"        let ruler_width = max([strlen(line('$')), (&numberwidth - 1)]) + &l:foldcolumn
"        let column_width = strlen(vc)
"        let padding = ruler_width - column_width
"        let column = ''
"
"        if padding <= 0
"            let column .= vc
"        else
"            " + 1 because for some reason vim eats one of the spaces
"            let column .= repeat(' ', padding + 1) . vc
"        endif
"
"        return column . ' '
"    endfunction
"
"    let stat .= '%#SLColumn#'
"    let stat .= '%{Column()}'
"    let stat .= '%*'
"
"    if getwinvar(a:winnum, 'statusline_progress', 0)
"        let stat .= Color(active, 'SLProgress', ' %p ')
"    endif
"
"    " file name
"    let stat .= Color(active, 'SLArrows', active ? ' »' : ' «')
"    let stat .= ' %<'
"    let stat .= '%f'
"    let stat .= ' ' . Color(active, 'SLArrows', active ? '«' : '»')
"
"    " file modified
"    let modified = getbufvar(bufnum, '&modified')
"    let stat .= Color(active, 'SLLineNr', modified ? ' +' : '')
"
"    " read only
"    let readonly = getbufvar(bufnum, '&readonly')
"    let stat .= Color(active, 'SLLineNR', readonly ? ' ‼' : '')
"
"    " paste
"    if active
"        if getwinvar(a:winnum, '&spell')
"            let stat .= Color(active, 'SLLineNr', ' S')
"        endif
"
"        if getwinvar(a:winnum, '&paste')
"            let stat .= Color(active, 'SLLineNr', ' P')
"        endif
"    endif
"
"    " right side
"    let stat .= '%='
"
"    " git branch
"    if exists('*fugitive#head')
"        let head = fugitive#head()
"
"        if empty(head) && exists('*fugitive#detect') && !exists('b:git_dir')
"            call fugitive#detect(getcwd())
"            let head = fugitive#head()
"        endif
"    endif
"
"    if !empty(head)
"        let stat .= Color(active, 'SLBranch', ' ← ') . head . ' '
"    endif
"
"    return stat
"endfunction " }}}
"
"" Status AutoCMD: {{{
"function! s:ToggleStatusProgress()
"    if !exists('w:statusline_progress')
"        let w:statusline_progress = 0
"    endif
"
"    let w:statusline_progress = !w:statusline_progress
"endfunction
"
"command! ToggleStatusProgress :call s:ToggleStatusProgress()
"
""nnoremap <silent>  :ToggleStatusProgress<CR>
"
"function! s:IsDiff()
"    let result = 0
"
"    for nr in range(1, winnr('$'))
"        let result = result || getwinvar(nr, '&diff')
"
"        if result
"            return result
"        endif
"    endfor
"
"    return result
"endfunction
"
"function! s:RefreshStatus()
"    for nr in range(1, winnr('$'))
"        call setwinvar(nr, '&statusline', '%!Status(' . nr . ')')
"    endfor
"endfunction
"
"command! RefreshStatus :call <SID>RefreshStatus()
"
"augroup status
"    autocmd!
"    autocmd VimEnter,VimLeave,WinEnter,WinLeave,BufWinEnter,BufWinLeave * :RefreshStatus
"augroup END
"" }}}"
"
"" }}}

" }}}

" Searching {{{

set ignorecase " be case insensitive
set gdefault   " always turn on global regex
set incsearch  " search as characters are entered
set hlsearch   " highlight matches
" in visual mode, press // to search for selected text
vnoremap // y/<C-R>"<CR> 

" Better cursor position
nnoremap n nzz
nnoremap N Nzz

if executable('ag')
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
" space open/close folds
nnoremap <space> za 

autocmd FileType vim setlocal foldmethod=marker

function! NeatFoldText() " {{{
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction " }}}

"function! NeatFoldText() " {{{
"    let line = getline(v:foldstart)
"
"    let nucolwidth = &fdc + &number * &numberwidth
"    let windowwidth = winwidth(0) - nucolwidth - 3
"    let foldedlinecount = v:foldend - v:foldstart
"
"    " expand tabs into spaces
"    let onetab = strpart('          ', 0, &tabstop)
"    let line = substitute(line, '\t', onetab, 'g')
"
"    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
"    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
"    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
"endfunction " }}}

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

" shift+j to scroll up
" shift+k to scroll down
nnoremap <S-j> <C-d>
nnoremap <S-k> <C-u>
vnoremap <S-j> <C-d>
vnoremap <S-k> <C-u>

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
    "set cursorline
end

" Macvim
if has('gui_macvim')
    set transparency=1
endif

" Neovim
if !has('nvim')
    set encoding=utf-8
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
