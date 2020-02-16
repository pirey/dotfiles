if exists('g:loaded_cursorline')
    finish
endif

let g:loaded_cursorline = 1

" cursorline only for active window
" and only if there are multiple window

" NOTE this can raise a performance issue somehow
augroup CurrentCursorline
    autocmd!
    autocmd InsertLeave,WinEnter * exe winnr('$')>1 ? "setlocal cursorline" : "setlocal nocursorline"
    autocmd InsertEnter,WinLeave * setlocal nocursorline
augroup END

