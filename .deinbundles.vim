" dein.vim {{{
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include dein and initialize
set runtimepath^=~/.vim/bundle/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/.cache/dein'))
" alternatively, pass a path where dein should install plugins
"call dein#begin('~/some/path/here')

" Required:
call dein#add('Shougo/dein.vim')

" Language
call dein#add('scrooloose/syntastic')    " Syntax checker
call dein#add('StanAngeloff/php.vim')    " PHP
call dein#add('yeripratama/vim-volt-syntax') " Volt
call dein#add('pangloss/vim-javascript') " Javascript
call dein#add('evidens/vim-twig') " Twig
call dein#add('captbaritone/better-indent-support-for-php-with-html')

" Editing
call dein#add('scrooloose/nerdcommenter') " Commenter `<leader>c<space>`
call dein#add('ervandew/supertab') " Commenter `<leader>c<space>`
call dein#add('Raimondi/delimitMate') " Auto add matching [({''})]
call dein#add('mattn/emmet-vim') " Emmet for vim `<c-y>,`
call dein#add('gregsexton/MatchTag') " Highlight matching html tag
call dein#add('tpope/vim-surround') " Surrounder `cs*`
call dein#add('godlygeek/tabular') " Aligning tool :Tabular /{pattern}

" UI
call dein#add('ap/vim-buftabline') " Buffer name on top of screen
call dein#add('flazz/vim-colorschemes') " All colorscheme
call dein#add('junegunn/goyo.vim') " Distraction free

" Navigation
call dein#add('junegunn/goyo.vim') " Distraction free
call dein#add('vim-scripts/BufOnly.vim') " Close all buffer but this one. :Bufonly
call dein#add('ctrlpvim/ctrlp.vim') " File searcher <c-p>
call dein#add('easymotion/vim-easymotion') " Jumping over places <leader><leader>w
call dein#add('scrooloose/nerdtree') " File browser <leader>d
call dein#add('majutsushi/tagbar') " List tags in sidebar
call dein#add('chrismccord/bclose.vim') " Close a buffer without closing split window

" Git
call dein#add('tpope/vim-fugitive')
call dein#add('airblade/vim-gitgutter') " Git changes sign
call dein#add('Xuyuanp/nerdtree-git-plugin') " Git status within nerdtree

" Fancy
" call dein#add('mhinz/vim-startify') " Fancy start screen
" call dein#add('bling/vim-airline') " Statusline
" call dein#add('vim-airline/vim-airline-themes') " Themes for airline plugin
" call dein#add('edkolev/tmuxline.vim') " Statusline for tmux
" call dein#add('ryanoasis/vim-devicons') " Fancy icons, require patched font (nerd font)

" Temporarily disabled plugins
call dein#add('chrisbra/NrrwRgn') " Separate selected text and edit it to new window :NR
" call dein#add('vim-utils/vim-man') " View other program's manual page in vim :Man
" call dein#add('vim-scripts/textutil.vim') " Open rtf, doc, rtfd, wordml as plain text (Mac only)
" call dein#add('vim-scripts/EasyGrep') " Easy find and replace
" call dein#add('terryma/vim-expand-region') " Select region
" call dein#add('itchyny/calendar.vim') " Calendar app
" call dein#add('vitalk/vim-simple-todo') " Simple todo app

if executable('ack') || executable('ack-grep')
    
    "Plugin 'ack.vim'           " Better than grep, they said http://beyondgrep.com
    "Plugin 'NERD_Tree-and-ack' " Find in folder, from nerdtree
endif

if executable('ag')
    " Seriously, use The Silver Searcher https://github.com/ggreer/the_silver_searcher
    call dein#add('rking/ag.vim')
endif

if dein#check_install()
	call dein#install()
endif

" All of your Plugins must be added before the following line
call dein#end()            " required
filetype plugin indent on    " required
" see :h dein for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" }}}
