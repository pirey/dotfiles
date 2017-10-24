" This is an additional file for my .vimrc
" I separated the main vimrc and plugin setting for easier maintenance
"
" Name:     .pluginconfig.vim
" Author:   Yeri <arifyeripratama@gmail.com>
" URL:      https://github.com/pirey/dotfiles
" License:  MIT license
" Created:  2015
" Modified: Frequently
" NOTE:     Press <space> to open/close folds

" Vim Plug {{{
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Util
Plug 'Shougo/vimproc.vim', {'do' : 'make'}                    " Async library

" Language & Syntax
Plug 'w0rp/ale'                                               " linter
Plug 'StanAngeloff/php.vim'                                   " PHP
" Plug 'evidens/vim-twig'                                     " Twig
Plug 'jwalton512/vim-blade'                                   " Laravel's Blade
Plug 'captbaritone/better-indent-support-for-php-with-html'
Plug 'pangloss/vim-javascript'                                " Javascript
Plug 'othree/javascript-libraries-syntax.vim'
" Plug 'digitaltoad/vim-pug'                                    " Pug template engine
Plug 'neoclide/vim-jsx-improve'                               " React's jsx
" Plug 'elmcast/elm-vim'
Plug 'lepture/vim-jinja'
Plug 'itchyny/vim-haskell-indent'

" UI & Colors
" Plug 'ap/vim-buftabline'                                    " Show buffer name on top of screen
Plug 'Yggdroot/indentLine'
Plug 'flazz/vim-colorschemes'                                 " A bunch of colorschemes
Plug 'junegunn/goyo.vim'                                      " Distraction free
Plug 'junegunn/limelight.vim'                                 " Distraction free++
Plug 'vim-scripts/ScrollColors'                               " colorscheme explorer
" Plug 'arcticicestudio/nord-vim'                               " Nord
" Plug 'whatyouhide/vim-gotham'

" Editing
Plug 'scrooloose/nerdcommenter'                               " Commenter `<leader>c<space>`
Plug 'mattn/emmet-vim'                                        " Emmet for vim `<c-y>,`
Plug 'tpope/vim-repeat'                                       " Repeat last plugin command
Plug 'tpope/vim-surround'                                     " Surrounder `cs*`
Plug 'godlygeek/tabular'                                      " Aligning tool :Tabular /{pattern}
Plug 'chrisbra/NrrwRgn'                                       " edit selected text to a new window
Plug 'Olical/vim-enmasse'                                     " Edit all files in the quickfix list
Plug 'editorconfig/editorconfig-vim'                          " Editor config
" Plug 'delimitMate.vim'                                      " Auto add matching [({''})]
" Plug 'MatchTag'                                             " Highlight matching html tag
" Plug 'ervandew/supertab'                                    " Auto complete <tab>


" Completion & Snippet

" fancy feature for fancy vim
if (v:version >= 800 && has('python') || has('python3'))
    Plug 'maralla/completor.vim', { 'do': 'make js' }         " this is just better than YCM

    " while we're at it, why don't use snippet engine?

    Plug 'SirVer/ultisnips'                                   " Snippet Engine
    Plug 'honza/vim-snippets'                                 " Snippets collections
endif

" Navigation
Plug 'nelstrom/vim-visual-star-search'                        " search for the selected text (press star in visual mode)
Plug 'vim-scripts/BufOnly.vim'                                " Close all buffer but current one.
Plug 'ctrlpvim/ctrlp.vim'                                     " File fuzzy finder <c-p>
Plug 'easymotion/vim-easymotion'                              " Jumping over places <leader><leader>w
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }       " File browser <leader>d
" Plug 'Tagbar'                                               " List tags in sidebar
Plug 'chrismccord/bclose.vim'                                 " Close a buffer without closing split window
Plug 'tpope/vim-unimpaired'                                   " pairs of handy bracket mappings
Plug 'mhinz/vim-grepper'                                      " Searching tool

" Git
Plug 'tpope/vim-fugitive'                                     " Git wrapper
Plug 'airblade/vim-gitgutter'                                 " Git changes sign
" Plug 'Xuyuanp/nerdtree-git-plugin'                          " Git status within nerdtree

" ETC
Plug 'tpope/vim-dispatch'
Plug 'diepm/vim-rest-console'                                 " making rest api call
Plug 'vim-utils/vim-man'                                      " View other program's manual page in vim :Man
" Plug 'Shougo/vimshell.vim'

" Fancy stuff for fun
" Plug 'mhinz/vim-startify'                                   " Fancy start screen
" Plug 'edkolev/tmuxline.vim'                                 " Statusline for tmux
" Plug 'textutil.vim'                                         " Open rtf, doc, rtfd, wordml as plain text (Mac only)
" Plug 'EasyGrep'                                             " Easy find and replace
" Plug 'terryma/vim-expand-region'                            " Select region
" Plug 'itchyny/calendar.vim'                                 " Calendar app
" Plug 'vitalk/vim-simple-todo'                               " Simple todo app
" Plug 'bling/vim-airline'                                    " Statusline
" Plug 'vim-airline/vim-airline-themes'                       " Themes for airline plugin
" Plug 'ryanoasis/vim-devicons'                               " Fancy icons, require patched font (nerd font)

if executable('rg')
    Plug 'jremmen/vim-ripgrep'                                " ripgrep https://github.com/BurntSushi/ripgrep
elseif executable('ag')
    Plug 'rking/ag.vim'                                       " The Silver Searcher https://github.com/ggreer/the_silver_searcher
else
    if executable('ack') || executable('ack-grep')
        Plug 'mileszs/ack.vim'                                " Better than grep, they said http://beyondgrep.com
        Plug 'tyok/nerdtree-ack'                              " Find in folder, from nerdtree
    endif

endif

" Initialize plugin system
call plug#end()
" }}}

" Plugin Settings {{{
"
" PHP.vim {{{

let php_sql_query = 1

"function! PhpSyntaxOverride()
"  hi! def link phpDocTags  phpDefine
"  hi! def link phpDocParam phpType
"endfunction
"
"augroup phpSyntaxOverride
"  autocmd!
"  autocmd FileType php call PhpSyntaxOverride()
"augroup END

" }}}

" Goyo - Limelight {{{
set showcmd

function! GoyoEnterHandler()
    Limelight
    set wrap
endfunction

function! GoyoLeaveHandler()
    Limelight!
    set nowrap
endfunction

autocmd! User GoyoEnter call GoyoEnterHandler()
autocmd! User GoyoLeave call GoyoLeaveHandler()

" Color name (:help cterm-colors) or ANSI code
"let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
let g:limelight_default_coefficient = 0.8

if has('gui_running')
    " Color name (:help gui-colors) or RGB color
    "let g:limelight_conceal_guifg = 'DarkGray'
    let g:limelight_conceal_guifg = '#777777'

endif
" }}}

" javascript-libraries-syntax.vim {{{
let g:used_javascript_libs = 'jquery,underscore,angularjs,angularui,angularuirouter'
" }}}

"" Supertab {{{
"" set default action to keyword completion
"let g:SuperTabDefaultCompletionType = '<c-p>'
"let g:SuperTabRetainCompletionDuration = 'session'
"let g:SuperTabCrMapping = 1
"autocmd FileType *
"\ if &omnifunc != '' |
"\   call SuperTabChain(&omnifunc, "<c-p>") |
"\ endif
"" }}}

" Buftabline {{{
let g:buftabline_indicators = 1
" }}}

" Bclose {{{

nnoremap <leader>x :Bclose<CR>

" }}}

" Tagbar {{{

nnoremap <leader>t :TagbarToggle<CR>

" }}}

" Fugitive {{{
" simpler than fugitive#statusline()
function! FugitiveStatusline(...) abort
  if !exists('b:git_dir')
    return ''
  endif
  return '['.fugitive#head(7).']'
endfunction

set statusline=\(%{toupper(mode())}\)\ %<%t\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P
" }}}

" Git Gutter {{{

let g:gitgutter_realtime = 0 " disable realtime update, in hope vim doesn't lag
let g:gitgutter_eager = 0
let g:gitgutter_max_signs = 250
nnoremap <leader>g :GitGutterToggle<CR>
nnoremap <leader>G :GitGutterLineHighlightsToggle<CR>
" hunk stage = <leader>hs
" hunk revert stage (unstage) = <leader>hr

" }}}

" Vim Airline & Tmuxline {{{
"let g:airline#extensions#tabline#enabled =1 " enable tabline
"let g:airline#extensions#tabline#fnamemod = ':t' " show only the file name

" User patched font to display icons
"let g:airline_powerline_fonts = 1

" If you don't have patched font installed,
" I recommend using this setting for nice & simple appearance
"let g:airline_left_sep = ''
"let g:airline_right_sep = ''

" Tmuxline
"let g:tmuxline_powerline_separators = 1
"let g:airline#extensions#tmuxline#enabled = 0 " Use custom theme for tmuxline
"let g:tmuxline_theme = 'airline'
"let g:tmuxline_preset = 'full'

" }}}

" NERDTree {{{

nnoremap <silent> <leader>d :NERDTreeToggle<CR>
nnoremap <silent> <leader>D :NERDTreeFind<CR>
let NERDTreeShowHidden=1
"let NERDTreeWinSize=40
"let g:NERDTreeDirArrows = 1
"let g:NERDTreeDirArrowExpandable = '▸'
"let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeStatusline = "FILES"

" }}}

" NERDCommenter {{{
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
" let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
"let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" }}}

" Emmet {{{
"
" }}}

" Surround {{{
"
" cs"'
" cs'<q>
" cst"
" ds"
" S<p class="something">
"
" }}}

" CtrlP {{{
"
" No need to reindex files when reopen CtrlP.
" NOTE: to refresh search list, use <F5>
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_show_hidden = 1

if executable('ag')
  "let g:ctrlp_use_caching = 0
  let g:ctrlp_user_command = "ag --hidden --nocolor --ignore .git -l -g '' %s"
endif

" }}}

" Indent Line {{{
nnoremap <leader>i :IndentLinesToggle<CR>
let g:indentLine_faster = 1
"let g:indentLine_char = '┊'
let g:indentLine_char = '·'
"let g:indentLine_enabled = 0
"let g:indentLine_leadingSpaceChar = '·'
"let g:indentLine_leadingSpaceEnabled = 1
" }}}

" ultisnip {{{
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger       = '<c-l>'
let g:UltiSnipsJumpForwardTrigger  = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
let g:UltiSnipsListSnippets        = '<c-s>'

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" }}}

" vim rest client {{{
let g:vrc_allow_get_request_body = 1
let g:vrc_elasticsearch_support = 1
" }}}

" Elm {{{
let g:elm_setup_keybindings = 0 " disable mapping
" }}}

" ALE (linter) {{{
" let g:ale_sign_error = '✗'
let g:ale_sign_error = '●'
" let g:ale_open_list = 1
let g:ale_lint_delay = 50
let g:ale_sign_column_always = 1
let g:ale_linters = {'javascript': ['standard']}
if (executable('standard'))
    let g:ale_javascript_standard_executable = 'standard'
    let g:ale_javascript_standard_use_global = 1
endif
let g:ale_fixers = { 'javascript': 'standard' }
let g:ale_fix_on_save = 1
let g:ale_lint_on_enter = 1
function! AleStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? '✔' : printf(
    \   '%dE %dW',
    \   all_errors,
    \   all_non_errors
    \)
endfunction

set statusline=\(%{toupper(mode())}\)\ %<%t\ %h%m%r%{FugitiveStatusline()}%=%-10{AleStatus()}%-14.(%l,%c%V%)\ %P
" highlight Error ctermbg=1 ctermfg=0
highlight link ALEErrorLine Error
" }}}

" }}}

" notify vimrc that statusline is already set
let g:statusline_set = 1
