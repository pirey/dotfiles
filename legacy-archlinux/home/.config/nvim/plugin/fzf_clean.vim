" simple plugin to make fzf ui clean

if exists('g:loaded_fzf_clean')
    finish
endif

let g:loaded_fzf_clean = 1


" hide statusline and tabline
" disable indentline when opening fzf
function! s:fzf_enter()
    " track previous state
    " if statusline/tabline is hidden at the time user open fzf,
    " then don't show it later when user leave fzf
    if &laststatus == 0
        let b:skip_statusline = 1
    endif
    if &showtabline == 0
        let b:skip_tabline = 1
    endif

    " clear command output
    echom ''

    setlocal nonumber norelativenumber
    set laststatus=0
    set showtabline=0
    set noshowmode noruler
    " execute 'IndentLinesDisable'
endfunction

function! s:fzf_leave()
    if exists('b:skip_statusline')
        unlet! b:skip_statusline
    else
        set laststatus=2
    endif

    if exists('b:skip_tabline')
        unlet! b:skip_tabline
    else
        set showtabline=2
    endif

    " set nonumber norelativenumber
    set noshowmode noruler

    " execute 'IndentLinesEnable'
endfunction

augroup custom_fzf
    autocmd!
    autocmd! FileType fzf call s:fzf_enter()
                \| autocmd BufLeave <buffer> call s:fzf_leave()
augroup END

