" cursorline only for active window
" and only if there are multiple window
augroup CurrentCursorline
    autocmd!
    autocmd WinEnter * exe winnr('$')>1 && &ft != 'nerdtree' ? "setlocal cursorline" : "setlocal nocursorline"
    autocmd WinLeave * setlocal nocursorline
augroup END

