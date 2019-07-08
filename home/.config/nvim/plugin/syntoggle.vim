if exists('g:syntoggle_loaded')
    finish
endif

let g:syntoggle_loaded = 1

function! SynToggle()
    if exists('g:syntax_on')
        syntax off
    else
        syntax enable

        " TODO can make this dynamic
        runtime init/highlight.vim
    endif
endfunction

command! SynToggle :call SynToggle()
