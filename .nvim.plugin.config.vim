" yats {{{
autocmd BufNewFile,BufRead *.ts,*.tsx setlocal filetype=typescript
" }}}

" deoplete {{{
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
            \ 'auto_complete_delay': 0,
            \ 'smart_case': v:true,
            \ 'delimiters': ['/', '.'],
            \ })
" }}}

" denite {{{
call denite#custom#var('file/rec', 'command',
            \ ['rg', '--files', '--glob', '!.git'])

call denite#custom#map(
            \ 'insert',
            \ '<C-j>',
            \ '<denite:move_to_next_line>',
            \ 'noremap'
            \)
call denite#custom#map(
            \ 'insert',
            \ '<C-k>',
            \ '<denite:move_to_previous_line>',
            \ 'noremap'
            \)
" }}}

" nvim-typescript {{{
autocmd FileType typescript nnoremap <buffer> <C-]> :TSTypeDef<CR>
" }}}
