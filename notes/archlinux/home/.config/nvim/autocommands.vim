function! s:handle_terminal_open()
    setlocal nobuflisted
    startinsert
    setlocal showmode
    setlocal noruler
endfunction

function! s:handle_terminal_close()
endfunction

augroup commmon_autocmd
    autocmd!
    autocmd TermOpen term://* call s:handle_terminal_open()
    autocmd TermClose term://* call s:handle_terminal_close()
augroup END
