function! s:get_tabline_right_section_len() abort
    " TODO let user specify right section len
    " 20 is maxlen of gitbranch component
    return 20
endfunction

function! s:get_pad_len() abort
    " TODO make this configurable
    return 30
endfunction

function! s:explorer_is_open() abort
    return get(s:, 'explorer_open', 0)
endfunction

function! s:explorer_set_open_state(s) abort
    let s:explorer_open = a:s
endfunction

function! s:has_space_for_pad() abort
    let l:right_section_len = s:get_tabline_right_section_len()
    let l:pad_len = s:get_pad_len()
    let l:buffers_len = s:get_buffers_len()
    let l:remaining_space = &columns - l:buffers_len - l:right_section_len
    return l:remaining_space > l:pad_len
endfunction

function! s:get_buffers_len() abort
    let l:buffers = lightline#bufferline#buffers()
    let l:buffers_len = 0
    for item in l:buffers
        for _item in item
            let l:buffers_len += len(_item)
        endfor
    endfor

    return l:buffers_len
endfunction

" TODO handle explorer on the right
function! lightline#explorer_pad#left_pad() abort
    if !s:explorer_is_open()
        return ''
    endif

    if &co < 86
        return ''
    endif

    if !s:has_space_for_pad()
        return ''
    endif

    let l:separator = '⎟'
    let l:space_len = s:get_pad_len() - 1
    return printf('%-' . l:space_len . 'S', '') . l:separator
endfunction

function! lightline#explorer_pad#init() abort
    augroup explorer_pad
        autocmd!
        " TODO allow user to specify other explorer
        autocmd BufEnter *coc-explorer* call s:explorer_set_open_state(1)
        autocmd BufHidden *coc-explorer* call s:explorer_set_open_state(0)
    augroup END
endfunction
