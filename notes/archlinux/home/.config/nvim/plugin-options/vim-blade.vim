" jwalton512/vim-blade {{{
" Define some single Blade directives. This variable is used for highlighting only.
let g:blade_custom_directives = ['csrf', 'method']

" Define pairs of Blade directives. This variable is used for highlighting and indentation.
let g:blade_custom_directives_pairs = {
            \   'error': 'enderror',
            \ }
" }}}

