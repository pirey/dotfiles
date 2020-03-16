" MIT License. Copyright (c) 2013-2020 Bailey Ling et al.
" vim: et ts=2 sts=2 sw=2 tw=80

scriptencoding utf-8

let g:airline#themes#base16_airline_solarized#palette = {}

let s:base16_colors = {
      \ 'black'  : 0,
      \ 'red'    : 1,
      \ 'green'  : 2,
      \ 'yellow' : 3,
      \ 'blue'   : 4,
      \ 'purple' : 5,
      \ 'cyan'   : 6,
      \ 'white'  : 7,
      \ 'gray'   : 8,
      \ 'light'  : 18
      \}

let s:modified_color = ['', '', s:base16_colors['green'], s:base16_colors['black']]

" normal {{{
let s:airline_a_normal   = [ '' , '' , s:base16_colors['light']  , s:base16_colors['white']]
let s:airline_b_normal   = [ '' , '' , s:base16_colors['white'], s:base16_colors['light'] ]
let s:airline_c_normal   = [ '' , '' , s:base16_colors['white']  , s:base16_colors['black']]
let g:airline#themes#base16_airline_solarized#palette.normal = airline#themes#generate_color_map(s:airline_a_normal, s:airline_b_normal, s:airline_c_normal)
let g:airline#themes#base16_airline_solarized#palette.normal_modified = {
      \ 'airline_c': s:modified_color
      \ }

" inactive {{{
let s:airline_a_inactive = [ '' , '' , s:base16_colors['white'] , s:base16_colors['light']]
let s:airline_b_inactive = [ '' , '' , s:base16_colors['white'] , s:base16_colors['light']]
let s:airline_c_inactive = [ '' , '' , s:base16_colors['white'] , s:base16_colors['light']]
let g:airline#themes#base16_airline_solarized#palette.inactive = airline#themes#generate_color_map(s:airline_a_inactive, s:airline_b_inactive, s:airline_c_inactive)
let g:airline#themes#base16_airline_solarized#palette.inactive_modified = {
      \ 'airline_c': s:modified_color
      \ }
" }}}

" insert {{{
let s:airline_a_insert = [ '' , '' , s:base16_colors['light']  , s:base16_colors['green']]
let s:airline_b_insert = [ '' , '' , s:base16_colors['white'] , s:base16_colors['light']]
let s:airline_c_insert = [ '' , '' , s:base16_colors['white']  , s:base16_colors['black']]
let g:airline#themes#base16_airline_solarized#palette.insert = airline#themes#generate_color_map(s:airline_a_insert, s:airline_b_insert, s:airline_c_insert)
let g:airline#themes#base16_airline_solarized#palette.insert_modified = {
      \ 'airline_c': s:modified_color
      \ }
let g:airline#themes#base16_airline_solarized#palette.insert_paste = {
      \ 'airline_a': s:airline_a_insert
      \ }
" }}}

" replace {{{
let s:airline_a_replace = [ s:airline_b_insert[0]   , s:airline_b_insert[1] , s:base16_colors['light'] , s:base16_colors['red']]
let s:airline_b_replace = s:airline_b_insert
let s:airline_c_replace = s:airline_c_insert
let g:airline#themes#base16_airline_solarized#palette.replace = airline#themes#generate_color_map(s:airline_a_replace, s:airline_b_replace, s:airline_c_replace)
let g:airline#themes#base16_airline_solarized#palette.replace_modified = g:airline#themes#base16_airline_solarized#palette.insert_modified
let g:airline#themes#base16_airline_solarized#palette.insert_paste = g:airline#themes#base16_airline_solarized#palette.insert_paste
" }}}

" visual {{{
let s:airline_a_visual = [ s:airline_b_insert[0]   , s:airline_b_insert[1] , s:base16_colors['light'] , s:base16_colors['yellow']]
let s:airline_b_visual = s:airline_b_insert
let s:airline_c_visual = s:airline_c_insert
let g:airline#themes#base16_airline_solarized#palette.visual = airline#themes#generate_color_map(s:airline_a_visual, s:airline_b_visual, s:airline_c_visual)
let g:airline#themes#base16_airline_solarized#palette.visual_modified = g:airline#themes#base16_airline_solarized#palette.insert_modified
let g:airline#themes#base16_airline_solarized#palette.insert_paste = g:airline#themes#base16_airline_solarized#palette.insert_paste
" }}}

" command {{{
let s:airline_a_commandline = [ s:airline_b_insert[0]   , s:airline_b_insert[1] , s:base16_colors['light'] , s:base16_colors['purple']]
let s:airline_b_commandline = s:airline_b_insert
let s:airline_c_commandline = s:airline_c_insert
let g:airline#themes#base16_airline_solarized#palette.commandline = airline#themes#generate_color_map(s:airline_a_commandline, s:airline_b_commandline, s:airline_c_commandline)
let g:airline#themes#base16_airline_solarized#palette.commandline_modified = g:airline#themes#base16_airline_solarized#palette.insert_modified
let g:airline#themes#base16_airline_solarized#palette.insert_paste = g:airline#themes#base16_airline_solarized#palette.insert_paste
" }}}
