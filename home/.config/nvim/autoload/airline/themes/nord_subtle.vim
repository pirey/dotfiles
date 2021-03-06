" Copyright (C) 2016-present Arctic Ice Studio <development@arcticicestudio.com>
" Copyright (C) 2016-present Sven Greb <development@svengreb.de>

" Project: Nord Vim
" Repository: https://github.com/arcticicestudio/nord-vim
" License: MIT

let s:nord_vim_version="0.15.0"
let g:airline#themes#nord_subtle#palette = {}

let s:nord0_gui = "#2E3440"
let s:nord1_gui = "#3B4252"
let s:nord2_gui = "#434C5E"
let s:nord3_gui = "#4C566A"
let s:nord3_gui_bright = "#616E88"
let s:nord4_gui = "#D8DEE9"
let s:nord5_gui = "#E5E9F0"
let s:nord6_gui = "#ECEFF4"
let s:nord7_gui = "#8FBCBB"
let s:nord8_gui = "#88C0D0"
let s:nord9_gui = "#81A1C1"
let s:nord10_gui = "#5E81AC"
let s:nord11_gui = "#BF616A"
let s:nord12_gui = "#D08770"
let s:nord13_gui = "#EBCB8B"
let s:nord14_gui = "#A3BE8C"
let s:nord15_gui = "#B48EAD"

let s:nord0_term = "NONE"
let s:nord1_term = "0"
let s:nord2_term = "NONE"
let s:nord4_term = "NONE"
let s:nord11_term = "1"
let s:nord14_term = "2"
let s:nord13_term = "3"
let s:nord9_term = "4"
let s:nord15_term = "5"
let s:nord8_term = "6"
let s:nord5_term = "7"
let s:nord3_term = "8"
let s:nord12_term = "11"
let s:nord10_term = "12"
let s:nord7_term = "14"
let s:nord6_term = "15"

let s:nord3_gui_brightened = [
  \ s:nord3_gui,
  \ "#4e586d",
  \ "#505b70",
  \ "#525d73",
  \ "#556076",
  \ "#576279",
  \ "#59647c",
  \ "#5b677f",
  \ "#5d6982",
  \ "#5f6c85",
  \ "#616e88",
  \ "#63718b",
  \ "#66738e",
  \ "#687591",
  \ "#6a7894",
  \ "#6d7a96",
  \ "#6f7d98",
  \ "#72809a",
  \ "#75829c",
  \ "#78859e",
  \ "#7b88a1",
\ ]

" NOTE: this theme is designed to be used for true color,
" TODO: highlight still jumpy
" TODO: need further adjustment if you want to use other color depth

let s:NMain = [s:nord4_gui, s:nord3_gui, s:nord1_term, s:nord8_term]
let s:NRight = [s:nord4_gui, s:nord1_gui, s:nord1_term, s:nord9_term]
let s:NMiddle = [s:nord5_gui, s:nord1_gui, s:nord5_term, s:nord3_term]
let s:NTabfill = [s:nord5_gui, s:nord0_gui, s:nord5_term, s:nord3_term]
let s:NTabhid = [s:nord5_gui, s:nord0_gui, s:nord5_term, s:nord3_term]
let s:NWarn = [s:nord1_gui, s:nord13_gui, s:nord3_term, s:nord13_term]
let s:NError = [s:nord0_gui, s:nord11_gui, s:nord1_term, s:nord11_term]

let g:airline#themes#nord_subtle#palette.normal = airline#themes#generate_color_map(s:NMain, s:NRight, s:NMiddle)
let g:airline#themes#nord_subtle#palette.normal.airline_warning = s:NWarn
let g:airline#themes#nord_subtle#palette.normal.airline_error = s:NError
let g:airline#themes#nord_subtle#palette.normal.airline_z = s:NRight
let g:airline#themes#nord_subtle#palette.normal.airline_tabfill = s:NTabfill
let g:airline#themes#nord_subtle#palette.normal.airline_tabhid = s:NTabhid

let g:airline#themes#nord_subtle#palette.insert = airline#themes#generate_color_map(s:NMain, s:NRight, s:NMiddle)
let g:airline#themes#nord_subtle#palette.insert.airline_warning = s:NWarn
let g:airline#themes#nord_subtle#palette.insert.airline_error = s:NError

let g:airline#themes#nord_subtle#palette.replace = airline#themes#generate_color_map(s:NMain, s:NRight, s:NMiddle)
let g:airline#themes#nord_subtle#palette.replace.airline_warning = s:NWarn
let g:airline#themes#nord_subtle#palette.replace.airline_error = s:NError

let g:airline#themes#nord_subtle#palette.visual = airline#themes#generate_color_map(s:NMain, s:NRight, s:NMiddle)
let g:airline#themes#nord_subtle#palette.visual.airline_warning = s:NWarn
let g:airline#themes#nord_subtle#palette.visual.airline_error = s:NError

let s:IAMain = [s:nord1_gui, s:nord1_gui, s:nord5_term, s:nord3_term]
let s:IARight = [s:nord1_gui, s:nord1_gui, s:nord5_term, s:nord3_term]
let s:IAMiddle = [s:nord3_gui_bright, s:nord1_gui, s:nord5_term, s:nord1_term]
let s:IAWarn = [s:nord1_gui, s:nord13_gui, s:nord3_term, s:nord13_term]
let s:IAError = [s:nord0_gui, s:nord11_gui, s:nord1_term, s:nord11_term]
let g:airline#themes#nord_subtle#palette.inactive = airline#themes#generate_color_map(s:IAMain, s:IARight, s:IAMiddle)
let g:airline#themes#nord_subtle#palette.inactive.airline_x = s:IAMain
let g:airline#themes#nord_subtle#palette.inactive.airline_warning = s:IAWarn
let g:airline#themes#nord_subtle#palette.inactive.airline_error = s:IAError

let g:airline#themes#nord_subtle#palette.normal.airline_term = s:NMiddle
let g:airline#themes#nord_subtle#palette.insert.airline_term = s:NMiddle
let g:airline#themes#nord_subtle#palette.replace.airline_term = s:NMiddle
let g:airline#themes#nord_subtle#palette.visual.airline_term = s:NMiddle
let g:airline#themes#nord_subtle#palette.inactive.airline_term = s:NMiddle

