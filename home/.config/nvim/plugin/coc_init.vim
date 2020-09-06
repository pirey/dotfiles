if exists('g:loaded_coc_init')
    finish
endif

let g:loaded_coc_init = 1

function! s:on_coc_init()
    let g:coc_ready = 1
endfunction

function! CocIsReady() abort
    return get(g:, 'coc_ready', 0)
endfunction

autocmd User CocNvimInit call s:on_coc_init()
