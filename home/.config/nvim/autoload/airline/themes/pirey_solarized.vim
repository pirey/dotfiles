" MIT License. Copyright (c) 2013-2020 Bailey Ling et al.
" vim: et ts=2 sts=2 sw=2 tw=80

scriptencoding utf-8

let g:airline#themes#pirey_solarized#palette = {}

" Keys in the dictionary are composed of the mode, and if specified the
" override.  For example:
"   * g:airline#themes#pirey_solarized#palette.normal
"       * the colors for a statusline while in normal mode
"   * g:airline#themes#pirey_solarized#palette.normal_modified
"       * the colors for a statusline while in normal mode when the buffer has
"         been modified
"   * g:airline#themes#pirey_solarized#palette.visual
"       * the colors for a statusline while in visual mode
"
" Values for each dictionary key is an array of color values that should be
" familiar for colorscheme designers:
"   * [guifg, guibg, ctermfg, ctermbg, opts]
" See "help attr-list" for valid values for the "opt" value.
"
" Each theme must provide an array of such values for each airline section of
" the statusline (airline_a through airline_z).  A convenience function,
" airline#themes#generate_color_map() exists to mirror airline_a/b/c to
" airline_x/y/z, respectively.

" The pirey_solarized.vim theme:
let s:airline_a_normal   = [ '#00005f' , '#dfff00' , 18  , 7   ]
let s:airline_b_normal   = [ '#ffffff' , '#444444' , 18, 19 ]
let s:airline_c_normal   = [ '#9cffd3' , '#202020' , 7  , 18 ]
let g:airline#themes#pirey_solarized#palette.normal = airline#themes#generate_color_map(s:airline_a_normal, s:airline_b_normal, s:airline_c_normal)

" It should be noted the above is equivalent to:
" let g:airline#themes#pirey_solarized#palette.normal = airline#themes#generate_color_map(
"    \  [ '#00005f' , '#dfff00' , 17  , 190 ],  " section airline_a
"    \  [ '#ffffff' , '#444444' , 255 , 238 ],  " section airline_b
"    \  [ '#9cffd3' , '#202020' , 85  , 234 ]   " section airline_c
"    \)
"
" In turn, that is equivalent to:
" let g:airline#themes#pirey_solarized#palette.normal = {
"    \  'airline_a': [ '#00005f' , '#dfff00' , 17  , 190 ],  "section airline_a
"    \  'airline_b': [ '#ffffff' , '#444444' , 255 , 238 ],  "section airline_b
"    \  'airline_c': [ '#9cffd3' , '#202020' , 85  , 234 ],  "section airline_c
"    \  'airline_x': [ '#9cffd3' , '#202020' , 85  , 234 ],  "section airline_x
"    \  'airline_y': [ '#ffffff' , '#444444' , 255 , 238 ],  "section airline_y
"    \  'airline_z': [ '#00005f' , '#dfff00' , 17  , 190 ]   "section airline_z
"    \}
"
" airline#themes#generate_color_map() also uses the values provided as
" parameters to create intermediary groups such as:
"   airline_a_to_airline_b
"   airline_b_to_airline_c
"   etc...

" Here we define overrides for when the buffer is modified.  This will be
" applied after g:airline#themes#pirey_solarized#palette.normal, hence why only certain keys are
" declared.
let g:airline#themes#pirey_solarized#palette.normal_modified = {
      \ 'airline_c': [ '#ffffff' , '#5f005f' , 7     , 0      , ''     ] ,
      \ }

let s:airline_a_insert = [ '#00005f' , '#dfff00' , 18  , 5   ]
let s:airline_b_insert = [ '#ffffff' , '#444444' , 7 , 18 ]
let s:airline_c_insert = [ '#9cffd3' , '#202020' , 7  , 0 ]
let g:airline#themes#pirey_solarized#palette.insert = airline#themes#generate_color_map(s:airline_a_insert, s:airline_b_insert, s:airline_c_insert)
let g:airline#themes#pirey_solarized#palette.insert_modified = {
      \ 'airline_c': [ '#ffffff' , '#5f005f' , 7     , 0      , ''     ] ,
      \ }
let g:airline#themes#pirey_solarized#palette.insert_paste = {
      \ 'airline_a': [ s:airline_a_insert[0]   , '#d78700' , 18 , 5     , ''     ] ,
      \ }


let g:airline#themes#pirey_solarized#palette.replace = copy(g:airline#themes#pirey_solarized#palette.insert)
let g:airline#themes#pirey_solarized#palette.replace.airline_a = [ s:airline_b_insert[0]   , '#af0000' , 18 , 1, '']
let g:airline#themes#pirey_solarized#palette.replace_modified = g:airline#themes#pirey_solarized#palette.insert_modified


let g:airline#themes#pirey_solarized#palette.visual = copy(g:airline#themes#pirey_solarized#palette.normal)
let g:airline#themes#pirey_solarized#palette.visual.airline_a = [ '#000000' , '#ffaf00' , 18, 2 ]
let g:airline#themes#pirey_solarized#palette.visual_modified = g:airline#themes#pirey_solarized#palette.normal_modified


let s:airline_a_inactive = [ '#4e4e4e' , '#1c1c1c' , 7 , 18 , '' ]
let s:airline_b_inactive = [ '#4e4e4e' , '#262626' , 7 , 18 , '' ]
let s:airline_c_inactive = [ '#4e4e4e' , '#303030' , 7 , 18 , '' ]
let g:airline#themes#pirey_solarized#palette.inactive = airline#themes#generate_color_map(s:airline_a_inactive, s:airline_b_inactive, s:airline_c_inactive)
let g:airline#themes#pirey_solarized#palette.inactive_modified = {
      \ 'airline_c': [ '#875faf' , '' , 97 , '' , '' ] ,
      \ }

" For commandline mode, we use the colors from normal mode, except the mode
" indicator should be colored differently, e.g. light green
let g:airline#themes#pirey_solarized#palette.commandline = copy(g:airline#themes#pirey_solarized#palette.normal)
let g:airline#themes#pirey_solarized#palette.commandline.airline_a = [ '#000000' , '#ffaf00' , 18, 3 ]
