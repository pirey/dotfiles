function! s:handle_terminal_open()
    setlocal nobuflisted
    startinsert
endfunction

augroup commmon_autocmd
    autocmd!
    autocmd TermOpen term://* call s:handle_terminal_open()
augroup END
