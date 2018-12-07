" connecting neovim with .vim directory
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" put this first because a lot of plugin mapping using <leader>
let mapleader = ","

call plug#begin('~/.vim/plugged')

source ~/.shared.plugin.vim

" neovim specific plugins here

source ~/.nvim.plugin.vim

call plug#end()

source ~/.shared.plugin.config.vim
" neovim plugin config {{{

source ~/.nvim.plugin.config.vim

" }}}
source ~/.config.vim
