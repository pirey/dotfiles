" this directory is to store vim-plug plugins
set runtimepath^=~/.vim-plug

" put this first because a lot of plugin mapping using <leader>
let mapleader = ","

" plugin {{{
call plug#begin('~/.vim-plug/plugged')

runtime plugs.vim

call plug#end()
" }}}

" option {{{
runtime options.vim
runtime! plugin-options/*.vim
" }}}

" mapping {{{
runtime mappings.vim
runtime! plugin-mappings/*.vim
" }}}

" command {{{
runtime commands.vim
" }}}
"
" autocommand {{{
runtime autocommands.vim
" }}}

" DIY statusline {{{
" runtime init/statusline.vim
" }}}

" highlight {{{
runtime highlights.vim
" }}}

let g:loaded_cursorline = 1
