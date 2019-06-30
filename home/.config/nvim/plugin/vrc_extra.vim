if exists('g:vrc_extra_loaded')
    finish
endif

let g:vrc_extra_loaded = 1

silent !mkdir -p ~/.vim-rest-console

command! -nargs=1 VRC :e ~/.vim-rest-console/<args>.rest
