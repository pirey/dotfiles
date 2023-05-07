" vim-airline/vim-airline {{{
let g:airline_section_c = '%m %t'

if g:colors_name == 'nord'
    let g:airline_theme='nord_subtle'
endif

" let g:airline_mode_map = {
"             \ '__'     : '-',
"             \ 'c'      : 'C',
"             \ 'i'      : 'I',
"             \ 'ic'     : 'I',
"             \ 'ix'     : 'I',
"             \ 'n'      : 'N',
"             \ 'multi'  : 'M',
"             \ 'ni'     : 'N',
"             \ 'no'     : 'N',
"             \ 'R'      : 'R',
"             \ 'Rv'     : 'R',
"             \ 's'      : 'S',
"             \ 'S'      : 'S',
"             \ ''     : 'S',
"             \ 't'      : 'T',
"             \ 'v'      : 'V',
"             \ 'V'      : 'V',
"             \ ''     : 'V',
"             \ }

" let g:airline_mode_map = {
"             \ '__'     : ' ',
"             \ 'c'      : ' ',
"             \ 'i'      : ' ',
"             \ 'ic'     : ' ',
"             \ 'ix'     : ' ',
"             \ 'n'      : ' ',
"             \ 'multi'  : ' ',
"             \ 'ni'     : ' ',
"             \ 'no'     : ' ',
"             \ 'R'      : ' ',
"             \ 'Rv'     : ' ',
"             \ 's'      : ' ',
"             \ 'S'      : ' ',
"             \ ''     : ' ',
"             \ 't'      : ' ',
"             \ 'v'      : ' ',
"             \ 'V'      : ' ',
"             \ ''     : ' ',
"             \ }

let g:airline#extensions#default#layout = [
            \ [ 'a', 'b', 'c' ],
            \ [ 'x', 'z', 'warning', 'error' ]
            \ ]

let g:airline#extensions#default#section_truncate_width = {
            \ 'b': 79,
            \ 'x': 88,
            \ 'y': 88,
            \ 'z': 60,
            \ 'warning': 90,
            \ 'error': 80,
            \ }

let g:airline_filetype_overrides = {
            \ 'coc-explorer': [ 'EXPLORER', '' ],
            \ }


" extensions
let g:airline#extensions#capslock#enabled = 1

let g:airline#extensions#coc#enabled = 1
let airline#extensions#coc#error_symbol = '● '

let g:airline#extensions#branch#displayed_head_limit = 10
" let g:airline#extensions#branch#sha1_len = 10

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t:.'

" prevent airilne from overriding tmux conf
let g:airline#extensions#tmuxline#enabled = 0

" powerline symbols {{{
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'


"    
"    

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
"
" }}}

" hi StatusLine ctermbg=0
" }}}

