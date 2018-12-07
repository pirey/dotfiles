" put this first because a lot of plugin mapping using <leader>
let mapleader = ","

call plug#begin('~/.vim/plugged')

source ~/.shared.plugin.vim

" vim specific plugins here
" Plug 'Quramy/tsuquyomi', { 'do': 'make', 'for': 'typescript' }

call plug#end()

source ~/.shared.plugin.config.vim
source ~/.config.vim
