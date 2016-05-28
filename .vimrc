" This is my personal vimrc [ https://github.com/yeripratama/dotfiles ]
"
"                        _ _      
"                       | | |     
" __   ___   _ _ __   __| | | ___ 
" \ \ / / | | | '_ \ / _` | |/ _ \
"  \ V /| |_| | | | | (_| | |  __/
"   \_/  \__,_|_| |_|\__,_|_|\___|

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

" Some useful plugins here
Plugin 'flazz/vim-colorschemes'         " All colorscheme
Plugin 'mhinz/vim-startify'             " Fancy start screen
Plugin 'ctrlpvim/ctrlp.vim'             " File searcher <c-p>
Plugin 'EasyMotion'                     " Jumping over places <leader><leader>w
Plugin 'The-NERD-tree'                  " File browser <leader>d
Plugin 'The-NERD-Commenter'             " Commenter `<leader>c<space>`
Plugin 'Xuyuanp/nerdtree-git-plugin'    " Git status within nerdtree
Plugin 'fugitive.vim'                   " Git wrapper
Plugin 'airblade/vim-gitgutter'         " Git changes sign
Plugin 'SuperTab'                       " Auto complete <tab>
Plugin 'delimitMate.vim'                " Auto add matching [({''})]
Plugin 'bling/vim-airline'              " Statusline
Plugin 'vim-airline/vim-airline-themes' " Themes for airline plugin
Plugin 'edkolev/tmuxline.vim'           " Statusline for tmux
Plugin 'mattn/emmet-vim'                " Emmet for vim `<c-y>,`
Plugin 'MatchTag'                       " Highlight matching html tag
Plugin 'BufOnly.vim'                    " Close all buffer but this one. :Bufonly
Plugin 'surround.vim'                   " Surrounder `cs*`
Plugin 'Tabular'                        " Aligning tool :Tabular /{pattern}
Plugin 'Tagbar'                         " List tags in sidebar
Plugin 'chrismccord/bclose.vim'         " Close a buffer without closing split window
Plugin 'Syntastic'                      " Syntax checker
Plugin 'StanAngeloff/php.vim'           " PHP
Plugin 'yeripratama/vim-volt-syntax'    " Phalcon's Volt
Plugin 'pangloss/vim-javascript'        " Javascript
Plugin 'evidens/vim-twig'               " Twig
Plugin 'ryanoasis/vim-devicons'         " Fancy icons, require patched font (nerd font)

" Temporarily disabled plugins
" Plugin 'NrrwRgn'                        " Separate selected text and edit it to new window :NR
" Plugin 'vim-utils/vim-man'              " View other program's manual page in vim :Man
" Plugin 'textutil.vim'                   " Open rtf, doc, rtfd, wordml as plain text (Mac only)
" Plugin 'EasyGrep'                       " Easy find and replace
" Plugin 'terryma/vim-expand-region'      " Select region
" Plugin 'itchyny/calendar.vim'           " Calendar app
" Plugin 'vitalk/vim-simple-todo'         " Simple todo app

if executable('ack') || executable('ack-grep')
    
    Plugin 'ack.vim'           " Better than grep, they said http://beyondgrep.com
    Plugin 'NERD_Tree-and-ack' " Find in folder, from nerdtree
endif

if executable('ag')
    " Seriously, use The Silver Searcher https://github.com/ggreer/the_silver_searcher
    Plugin 'rking/ag.vim'
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

"        _             _                  _   _   _                 
"       | |           (_)                | | | | (_)                
"  _ __ | |_   _  __ _ _ _ __    ___  ___| |_| |_ _ _ __   __ _ ___ 
" | '_ \| | | | |/ _` | | '_ \  / __|/ _ \ __| __| | '_ \ / _` / __|
" | |_) | | |_| | (_| | | | | | \__ \  __/ |_| |_| | | | | (_| \__ \
" | .__/|_|\__,_|\__, |_|_| |_| |___/\___|\__|\__|_|_| |_|\__, |___/
" | |             __/ |                                    __/ |    
" |_|            |___/                                    |___/     
"
" Plugin Settings

" PHP.vim
function! PhpSyntaxOverride()
  hi! def link phpDocTags  phpDefine
  hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

nnoremap <leader><leader>s :SyntasticToggleMode<CR>

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Angular & Ionic syntastic ignore
let g:syntastic_html_tidy_ignore_errors=["<ion-", "discarding unexpected </ion-",  'proprietary attribute "ng-', 'proprietary attribute "ng-']

" Bclose
nnoremap <leader>bd :Bclose<CR>

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

" User patched font to display icons
let g:airline_powerline_fonts = 1 

" If you don't have patched font installed, 
" I recommend using this setting for nice & simple appearance
"let g:airline_left_sep = ''
"let g:airline_right_sep = ''

" Tmuxline
let g:tmuxline_powerline_separators = 1
let g:airline#extensions#tmuxline#enabled = 0 " Use custom theme for tmuxline
let g:tmuxline_theme = 'airline_visual'
let g:tmuxline_preset = 'minimal'

" NERDTree
nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <leader>D :NERDTreeFind<CR>
let NERDTreeShowHidden=1

" Emmet-Vim, use this to trigger <c-y>,

" Surround cheatsheet
" cs"'
" cs'<q>
" cst"
" ds"
" S<p class="something">

" CtrlP
" No need to reindex files when reopen CtrlP.
" to refresh search list, use <F5>
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_show_hidden = 1

"                                  _ 
"                                 | |
"   __ _  ___ _ __   ___ _ __ __ _| |
"  / _` |/ _ \ '_ \ / _ \ '__/ _` | |
" | (_| |  __/ | | |  __/ | | (_| | |
"  \__, |\___|_| |_|\___|_|  \__,_|_|
"   __/ |                            
"  |___/                             
"
" General

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

"            _                
"           | |               
"   ___ ___ | | ___  _ __ ___ 
"  / __/ _ \| |/ _ \| '__/ __|
" | (_| (_) | | (_) | |  \__ \
"  \___\___/|_|\___/|_|  |___/
"
" Colors
                             
syntax enable " enable syntax processing
set background=dark
set t_Co=256 " set terminal color to use 256

" Some of my favorite colors
silent! colorscheme Tomorrow-Night " Chose this color if it's exists, surpress the error if it isn't
silent! colorscheme gruvbox        " Chose this color if it's exists, surpress the error if it isn't

" fixing incorrect background when displaying italic fonts
let  g:gruvbox_italic = 0

" Enable transparent background
hi Normal ctermbg=NONE

" Provide shortcut for some of my favorite colorschemes
nnoremap <leader><leader>so :call SetSolarized()<CR>
nnoremap <leader><leader>gru :call SetGruvbox()<CR>
nnoremap <leader><leader>to :call SetTomorrowNight()<CR>

" Gruvbox
function! SetGruvbox()
    if has('gui_running')
        " force airline to use the theme of this colorscheme,
        " since gruvbox has no airline theme (lucius)
        silent! colorscheme lucius
    else
        " can't find gruvbox theem for airline, use this instead
        let g:airline_theme = 'lucius'
    endif

    silent! colorscheme gruvbox
    set background=dark
endfunction

" Solarized
function! SetSolarized()
    let g:solarized_termtrans=1
    "let g:solarized_termcolors=256
    silent! colorscheme solarized
    "
    if !has('gui_running')
        let g:airline_theme = 'solarized'
    endif
endfunction

" Tomorrow-Night
function! SetTomorrowNight()
    silent! colorscheme Tomorrow-Night

    if !has('gui_running')
        let g:airline_theme = 'tomorrow'
    endif
endfunction

" Toggle background
" http://tilvim.com/2013/07/31/swapping-bg.html
map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>

" call default colorscheme here
call SetGruvbox()

"                                      _        _     
"                                     | |      | |    
"  ___ _ __   __ _  ___ ___   ______  | |_ __ _| |__  
" / __| '_ \ / _` |/ __/ _ \ |______| | __/ _` | '_ \ 
" \__ \ |_) | (_| | (_|  __/          | || (_| | |_) |
" |___/ .__/ \__,_|\___\___|           \__\__,_|_.__/ 
"     | |                                             
"     |_|                                             
"
" Space - Tab

set tabstop=4 " tab width
set softtabstop=4 " show existing tab with 4 spaces width
set shiftwidth=4 " when indenting with '>', use 4 spaces width
set expandtab " On pressing tab, insert 4 spaces
set backspace=indent,eol,start " backspace hapus tab, end of line, start line

"        _ 
"       (_)
"  _   _ _ 
" | | | | |
" | |_| | |
"  \__,_|_|
" 
" UI
          
          
set number                  " show line numbers
set norelativenumber        " default use no relative numbering.
set showcmd                 " show command in bottom bar
set wildmenu                " visual autocomplete for command menu
set formatoptions-=cro      " disable auto comment
set nowrap                  " nowrap line
set diffopt +=vertical      " open diffs in vertical split.
set listchars=tab:▸\ ,eol:¬
set splitright              " open new vsplit to the right
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


"                          _     _             
"                         | |   (_)            
"  ___  ___  __ _ _ __ ___| |__  _ _ __   __ _ 
" / __|/ _ \/ _` | '__/ __| '_ \| | '_ \ / _` |
" \__ \  __/ (_| | | | (__| | | | | | | | (_| |
" |___/\___|\__,_|_|  \___|_| |_|_|_| |_|\__, |
"                                         __/ |
"                                        |___/ 
" Searching

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

"   __      _     _ _             
"  / _|    | |   | (_)            
" | |_ ___ | | __| |_ _ __   __ _ 
" |  _/ _ \| |/ _` | | '_ \ / _` |
" | || (_) | | (_| | | | | | (_| |
" |_| \___/|_|\__,_|_|_| |_|\__, |
"                            __/ |
"                           |___/ 
"
" Folding

set foldenable " enable folding
set foldlevelstart=10 " open most folds by default
set foldnestmax=10 " 10 nested fold max
set foldmethod=indent " fold based on indent level
" space open/close folds
nnoremap <space> za 

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

"                                                _   
"                                               | |  
"  _ __ ___   _____   _____ _ __ ___   ___ _ __ | |_ 
" | '_ ` _ \ / _ \ \ / / _ \ '_ ` _ \ / _ \ '_ \| __|
" | | | | | | (_) \ V /  __/ | | | | |  __/ | | | |_ 
" |_| |_| |_|\___/ \_/ \___|_| |_| |_|\___|_| |_|\__|
"
" Movement
                                                    
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

"       _ _       _                         _ 
"      | (_)     | |                       | |
"   ___| |_ _ __ | |__   ___   __ _ _ __ __| |
"  / __| | | '_ \| '_ \ / _ \ / _` | '__/ _` |
" | (__| | | |_) | |_) | (_) | (_| | | | (_| |
"  \___|_|_| .__/|_.__/ \___/ \__,_|_|  \__,_|
"          | |                                
"          |_|                                
"
" Clipboard

if has('clipboard')

    " Only enable mouse when vim has clipboard support
    if has('mouse')
        set mouse=a
    endif

    " Use ctrl-c to copy selected text to clipboard
    vmap <C-c> "+y
endif
set pastetoggle=<leader>p

"                              _             
"                             (_)            
"  _ __ ___   __ _ _ __  _ __  _ _ __   __ _ 
" | '_ ` _ \ / _` | '_ \| '_ \| | '_ \ / _` |
" | | | | | | (_| | |_) | |_) | | | | | (_| |
" |_| |_| |_|\__,_| .__/| .__/|_|_| |_|\__, |
"                 | |   | |             __/ |
"                 |_|   |_|            |___/ 
"
" Mapping

nnoremap ; :
vnoremap ; :

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

"              _       __                             _           
"             (_)     / /                            (_)          
"   __ _ _   _ _     / /   _ __ ___   __ _  _____   ___ _ __ ___  
"  / _` | | | | |   / /   | '_ ` _ \ / _` |/ __\ \ / / | '_ ` _ \ 
" | (_| | |_| | |  / /    | | | | | | (_| | (__ \ V /| | | | | | |
"  \__, |\__,_|_| /_/     |_| |_| |_|\__,_|\___| \_/ |_|_| |_| |_|
"   __/ |                                                         
"  |___/                                                          
"
" GUI / Mac Vim

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

"  _   _                 _           
" | \ | |               (_)          
" |  \| | ___  _____   ___ _ __ ___  
" | . ` |/ _ \/ _ \ \ / / | '_ ` _ \ 
" | |\  |  __/ (_) \ V /| | | | | | |
" |_| \_|\___|\___/ \_/ |_|_| |_| |_|
"
" Neovim

 if !has('nvim')
     " neovim use utf8 as default, and we will get error when sourcing vimrc
     " if we declare it outside this block
     set encoding=utf-8
	 set ttymouse=xterm2
 else
 endif

"                 _                  
"                | |                 
"   ___ _   _ ___| |_ ___  _ __ ___  
"  / __| | | / __| __/ _ \| '_ ` _ \ 
" | (__| |_| \__ \ || (_) | | | | | |
"  \___|\__,_|___/\__\___/|_| |_| |_|
"
" Custom

" Load global custom configuration if exists

if filereadable(expand("~/.vimrc.custom"))
    source ~/.vimrc.custom
endif

"  _                 _ 
" | |               | |
" | | ___   ___ __ _| |
" | |/ _ \ / __/ _` | |
" | | (_) | (_| (_| | |
" |_|\___/ \___\__,_|_|

" Load local (per project) custom configuration if exists

if filereadable(expand(".vimrc.local"))
    source .vimrc.local
endif

" ETC
