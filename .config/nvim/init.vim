" connecting neovim with .vim directory
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" put this first because a lot of plugin mapping using <leader>
let mapleader = ","

" plugin {{{
call plug#begin('~/.vim/plugged')

source ~/.plugin.vim
source ~/.nvim.plugin.vim

call plug#end()
" }}}

" plugin config {{{
source ~/.plugin.config.vim
source ~/.nvim.plugin.config.vim
" }}}

" config {{{
source ~/.config.vim
" }}}
