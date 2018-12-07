" put this first because a lot of plugin mapping using <leader>
let mapleader = ","

" plugin {{{
call plug#begin('~/.vim/plugged')

source ~/.plugin.vim

" vim specific plugins here
" Plug 'Quramy/tsuquyomi', { 'do': 'make', 'for': 'typescript' }

call plug#end()
" }}}

" plugin config {{{
source ~/.plugin.config.vim
" }}}

" config {{{
source ~/.config.vim
" }}}
