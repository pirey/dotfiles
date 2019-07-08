if exists('g:loaded_copy')
    finish
endif

let g:loaded_copy = 1

if has('clipboard')

    " Only enable mouse when vim has clipboard support
    " otherwise we will get hard time copying stuff to the clipboard
    if has('mouse')
        set mouse=a
    endif

    " Use ctrl-c to copy selected text to clipboard
    vmap <C-c> "+y
else
    echo 'Woy, why not have clipboard bruh?'
endif
