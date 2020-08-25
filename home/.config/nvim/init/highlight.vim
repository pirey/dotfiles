" function for dynamic highlight color
" taken from nord.vim
function! s:hi(group, guifg, guibg, ctermfg, ctermbg, attr, guisp)
  if a:guifg != ""
    exec "hi " . a:group . " guifg=" . a:guifg
  endif
  if a:guibg != ""
    exec "hi " . a:group . " guibg=" . a:guibg
  endif
  if a:ctermfg != ""
    exec "hi " . a:group . " ctermfg=" . a:ctermfg
  endif
  if a:ctermbg != ""
    exec "hi " . a:group . " ctermbg=" . a:ctermbg
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr . " cterm=" . substitute(a:attr, "undercurl", "underline", "")
  endif
  if a:guisp != ""
    exec "hi " . a:group . " guisp=" . a:guisp
  endif
endfunction

" Different highlight for different color mode
if has('termguicolors')
    if g:colors_name == 'nord'
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

        let s:nord1_term = "0"
        let s:nord3_term = "8"
        let s:nord5_term = "7"
        let s:nord6_term = "15"
        let s:nord7_term = "14"
        let s:nord8_term = "6"
        let s:nord9_term = "4"
        let s:nord10_term = "12"
        let s:nord11_term = "1"
        let s:nord12_term = "11"
        let s:nord13_term = "3"
        let s:nord14_term = "2"
        let s:nord15_term = "5"

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

        call s:hi('EndOfBuffer', s:nord0_gui, '', '', '', '', '')
        call s:hi('StatusLine', '', s:nord1_gui, '', '', '', '')
        call s:hi('StatusLineNC', '', s:nord1_gui, '', '', '', '')
        call s:hi('Visual', '', s:nord1_gui, '', '', '', '')
        call s:hi('Search', 'NONE', s:nord1_gui, '', '', '', '')
        call s:hi('IncSearch', 'NONE', s:nord1_gui, '', '', '', '')
        call s:hi('ErrorMsg', s:nord11_gui, 'NONE', '', '', '', '')
        call s:hi('WarningMsg', s:nord13_gui, 'NONE', '', '', '', '')

        hi TablineFill guibg=NONE
        hi link QuickFixLine Visual

        " nord quirks
        hi! link javascriptVariable Function
        hi! link javascriptMethod Function

        " rhysd/git-messenger.vim {{{
        call s:hi('gitmessengerPopupNormal', '', s:nord1_gui, '', '', '', '')
        " }}}

        " APZelos/blamer.nvim {{{
        call s:hi('Blamer', s:nord2_gui, '', '', '', '', '')
        " }}}
    endif
endif
