" =============================================================================
" Filename: autoload/lightline/colorscheme/nord.vim
" Author: arcticicestudio
" License: MIT
" Last Change: 2017/11/12 20:27:51
" =============================================================================

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:nord0 = ["#2E3440", "NONE"]
let s:nord1 = ["#3B4252", 0]
let s:nord2 = ["#434C5E", "NONE"]
let s:nord3 = ["#4C566A", 8]
let s:nord4 = ["#D8DEE9", "NONE"]
let s:nord5 = ["#E5E9F0", 7]
let s:nord6 = ["#ECEFF4", 15]
let s:nord7 = ["#8FBCBB", 14]
let s:nord8 = ["#88C0D0", 6]
let s:nord9 = ["#81A1C1", 4]
let s:nord10 = ["#5E81AC", 12]
let s:nord11 = ["#BF616A", 1]
let s:nord12 = ["#D08770", 11]
let s:nord13 = ["#EBCB8B", 3]
let s:nord14 = ["#A3BE8C", 2]
let s:nord15 = ["#B48EAD", 5]

let s:nord3_bright = ["#616E88", 8]

" some alias
let s:bg = s:nord0
let s:light_bg = s:nord1
let s:fg = s:nord4
let s:light_fg = s:nord3

let s:p.normal.left = [ [ s:nord4, s:nord3, 'bold' ], [ s:nord4, s:nord1 ] ]
let s:p.normal.middle = [ [ s:nord4, s:nord1 ] ]
" let s:p.normal.right = [ [ s:nord4, s:light_bg ] ]
let s:p.normal.right = [ [ s:nord4, s:light_bg ] ]
let s:p.normal.warning = [ [ s:nord1, s:nord13 ] ]
let s:p.normal.error = [ [ s:nord1, s:nord11 ] ]

let s:p.inactive.left =  [ [ s:nord3_bright, s:nord1 ], [ s:nord1, s:nord1 ] ]
let s:p.inactive.middle = [ [ s:nord1, s:nord1 ] ]
let s:p.inactive.right = [ [ s:nord1, s:nord1 ], [ s:nord1, s:nord1 ] ]

let s:p.insert.left = [ [ s:nord4, s:nord3, 'bold' ], [ s:nord4, s:nord1 ] ]
let s:p.replace.left = [ [ s:nord4, s:nord3, 'bold' ], [ s:nord4, s:nord1 ] ]
let s:p.visual.left = [ [ s:nord4, s:nord3, 'bold' ], [ s:nord4, s:nord1 ] ]

" tabline with line version
" let s:p.tabline.left = [ [s:bg, s:bg], [ s:nord3_bright, s:light_bg ] ]
" let s:p.tabline.middle = [ [ s:light_bg, s:light_bg ] ]
" let s:p.tabline.right = [ [ s:fg, s:light_bg, 'bold' ] ]
" let s:p.tabline.tabsel = [ [ s:fg, s:bg, 'bold' ] ]

" tabline no line version
let s:p.tabline.left = [ [ s:nord2, s:nord0 ], [ s:nord3_bright, s:bg ] ]
let s:p.tabline.middle = [ [ s:nord0, s:nord0 ] ]
let s:p.tabline.right = [ [ s:nord3_bright, s:nord0, 'bold' ] ]
let s:p.tabline.tabsel = [ [ s:nord4, s:light_bg, 'bold' ] ]

let g:lightline#colorscheme#nord_subtle#palette = lightline#colorscheme#flatten(s:p)

