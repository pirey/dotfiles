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

" custom highlight for ALE {{{
highlight ALEError cterm=NONE ctermbg=18 ctermfg=6
highlight ALEErrorSign cterm=NONE ctermbg=0 ctermfg=6
highlight ALEWarning cterm=NONE ctermbg=18 ctermfg=4
highlight ALEWarningSign cterm=NONE ctermbg=0 ctermfg=4
" }}}

" nvm-typescript highlight {{{
let g:nvim_typescript#default_signs =
            \ get(g:, 'nvim_typescript#default_signs', [
            \  {
            \  'TSerror': {
            \   'texthl': 'ALEError',
            \   'signText': '●',
            \   'signTexthl': 'ALEErrorSign'
            \  }
            \},
            \{
            \  'TSwarning': {
            \   'texthl': 'ALEWarning',
            \   'signText': '●',
            \   'signTexthl': 'ALEWarningSign'
            \  }
            \},
            \{
            \  'TSinformation': {
            \   'texthl': 'SpellBad',
            \   'signText': '●',
            \   'signTexthl': 'NeomakeInfoSign'
            \   }
            \},
            \{
            \  'TShint': {
            \   'texthl': 'SpellBad',
            \   'signText': '?',
            \   'signTexthl': 'NeomakeInfoSign'
            \   }
            \}
            \])
" }}}

" }}}
