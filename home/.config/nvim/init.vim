" connecting neovim with .vim directory
" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath

" put this first because a lot of plugin mapping using <leader>
let mapleader = ","

" plugin {{{
call plug#begin('~/.vim-plug')

runtime init/plugin.vim

call plug#end()
" }}}

" plugin config {{{
runtime init/plugin.config.vim
" }}}

" config {{{
runtime init/general.vim
runtime init/highlight.vim
" }}}
