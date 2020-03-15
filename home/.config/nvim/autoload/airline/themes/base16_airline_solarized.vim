" MIT License. Copyright (c) 2013-2020 Bailey Ling et al.
" vim: et ts=2 sts=2 sw=2 tw=80

scriptencoding utf-8

let g:airline#themes#base16_airline_solarized#palette = {}

" normal {{{
let s:airline_a_normal   = [ '' , '' , 18  , 7   ]
let s:airline_b_normal   = [ '' , '' , 18, 19 ]
let s:airline_c_normal   = [ '' , '' , 7  , 0 ]
let g:airline#themes#base16_airline_solarized#palette.normal = airline#themes#generate_color_map(s:airline_a_normal, s:airline_b_normal, s:airline_c_normal)
let g:airline#themes#base16_airline_solarized#palette.normal_modified = {
      \ 'airline_c': [ '#875faf' , '' , 3 , 0 , '' ] ,
      \ }

" inactive {{{
let s:airline_a_inactive = [ '' , '' , 7 , 18 , '' ]
let s:airline_b_inactive = [ '' , '' , 7 , 18 , '' ]
let s:airline_c_inactive = [ '' , '' , 7 , 18 , '' ]
let g:airline#themes#base16_airline_solarized#palette.inactive = airline#themes#generate_color_map(s:airline_a_inactive, s:airline_b_inactive, s:airline_c_inactive)
let g:airline#themes#base16_airline_solarized#palette.inactive_modified = {
      \ 'airline_c': [ '' , '' , 3, '' , '' ] ,
      \ }
" }}}

" insert {{{
let s:airline_a_insert = [ '' , '' , 18  , 3   ]
let s:airline_b_insert = [ '' , '' , 7 , 18 ]
let s:airline_c_insert = [ '' , '' , 7  , 0 ]
let g:airline#themes#base16_airline_solarized#palette.insert = airline#themes#generate_color_map(s:airline_a_insert, s:airline_b_insert, s:airline_c_insert)
let g:airline#themes#base16_airline_solarized#palette.insert_modified = {
      \ 'airline_c': [ '' , '' , 3     , 0      , ''     ] ,
      \ }
let g:airline#themes#base16_airline_solarized#palette.insert_paste = {
      \ 'airline_a': [ s:airline_a_insert[0]   , s:airline_a_insert[1] , 18 , 3     , ''     ] ,
      \ }
" }}}

" replace {{{
let s:airline_a_replace = [ s:airline_b_insert[0]   , s:airline_b_insert[1] , 18 , 1, '']
let s:airline_b_replace = s:airline_b_insert
let s:airline_c_replace = s:airline_c_insert
let g:airline#themes#base16_airline_solarized#palette.replace = airline#themes#generate_color_map(s:airline_a_replace, s:airline_b_replace, s:airline_c_replace)
let g:airline#themes#base16_airline_solarized#palette.replace_modified = g:airline#themes#base16_airline_solarized#palette.insert_modified
let g:airline#themes#base16_airline_solarized#palette.insert_paste = g:airline#themes#base16_airline_solarized#palette.insert_paste
" }}}

" visual {{{
let s:airline_a_visual = [ s:airline_b_insert[0]   , s:airline_b_insert[1] , 18 , 2, '']
let s:airline_b_visual = s:airline_b_insert
let s:airline_c_visual = s:airline_c_insert
let g:airline#themes#base16_airline_solarized#palette.visual = airline#themes#generate_color_map(s:airline_a_visual, s:airline_b_visual, s:airline_c_visual)
let g:airline#themes#base16_airline_solarized#palette.visual_modified = g:airline#themes#base16_airline_solarized#palette.insert_modified
let g:airline#themes#base16_airline_solarized#palette.insert_paste = g:airline#themes#base16_airline_solarized#palette.insert_paste
" }}}

" command {{{
let s:airline_a_commandline = [ s:airline_b_insert[0]   , s:airline_b_insert[1] , 18 , 5, '']
let s:airline_b_commandline = s:airline_b_insert
let s:airline_c_commandline = s:airline_c_insert
let g:airline#themes#base16_airline_solarized#palette.commandline = airline#themes#generate_color_map(s:airline_a_commandline, s:airline_b_commandline, s:airline_c_commandline)
let g:airline#themes#base16_airline_solarized#palette.commandline_modified = g:airline#themes#base16_airline_solarized#palette.insert_modified
let g:airline#themes#base16_airline_solarized#palette.insert_paste = g:airline#themes#base16_airline_solarized#palette.insert_paste
" }}}
