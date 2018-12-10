" put this first because a lot of plugin mapping using <leader>
let mapleader = ","

" plugin {{{
call plug#begin('~/.vim/plugged')

source ~/.plugin.vim

call plug#end()
" }}}

" plugin config {{{
source ~/.plugin.config.vim
" }}}

" config {{{
source ~/.config.vim
" }}}
