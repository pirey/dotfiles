" this directory is to store vim-plug plugins
set runtimepath^=~/.vim-plug

" put this first because a lot of plugin mapping using <leader>
let mapleader = ","

" plugin {{{
call plug#begin('~/.vim-plug/plugged')

runtime init/plugin.vim

call plug#end()
" }}}

" option {{{
runtime init/option.vim
runtime init/plugin-option.vim
" }}}

" mapping {{{
runtime init/mapping.vim
runtime init/plugin-mapping.vim
" }}}

" command {{{
runtime init/command.vim
" }}}


" I guess i have to turn off highlighting until I upgrade my laptop :(
" syntax highlight is too sloooooowwww...
syntax off

" highlight {{{
runtime init/highlight.vim
" }}}

" set re=1
let g:loaded_cursorline = 1
