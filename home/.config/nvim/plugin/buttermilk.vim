" buttermilk.nvim - A bitter way of using the terminal in Neovim.
" Maintainer:	Adam P. Regasz-Rethy (RRethy) <rethy.spud@gmail.com>

if exists('g:loaded_buttermilk')
    finish
endif

let g:loaded_buttermilk = 1

nnoremap <silent> gt :<C-u>call <SID>toggle_term()<CR>

" winid => bg winid
let s:buttermilk_windows = {}

augroup buttermilk_autocmds
    autocmd!
    " autocmd WinClosed * echom <afile>
augroup END

fun! s:toggle_term() abort
    if !s:close()
        call s:open()
    endif
endf

fun! s:open() abort
    if !exists('s:term_bufnr')
        let s:term_bufnr = -1
    endif

    " try to find a terminal buffer
    if !bufexists(s:term_bufnr)
        for bufnr in nvim_list_bufs()
            let bufname = bufname(bufnr)
            echom bufname
            if bufname =~# 'term://'
                let s:term_bufnr = bufnr
                break
            endif
        endfor
    endif

    let width = float2nr(&columns * 0.9)
    let height = float2nr(&lines * 0.8)
    let opts = {
                \     'relative': 'editor',
                \     'row': (&lines - height) / 2.5,
                \     'col': (&columns - width) / 2,
                \     'width': width,
                \     'height': height,
                \     'style': 'minimal'
                \ }
    let bg_win_handle = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    let opts.height -= 2
    let opts.width -= 4
    let opts.row += 1
    let opts.col += 2
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    if !bufexists(s:term_bufnr)
        terminal
        let s:term_bufnr = bufnr('%')
    endif
    exe 'b '.s:term_bufnr
    setlocal winhighlight=NormalFloat:Normal
    startinsert
endf

fun! s:close() abort
    if exists('s:term_bufnr') && bufexists(s:term_bufnr)
        let winids = win_findbuf(s:term_bufnr)
        let curtabnr = tabpagenr()
        for winid in winids
            let [tabnr, winnr] = win_id2tabwin(winid)
            if curtabnr == tabnr
                call win_gotoid(winid)
                close
                close
                return 1
            endif
        endfor
    endif
    return 0
endf

