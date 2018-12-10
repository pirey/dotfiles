" yats {{{
autocmd BufNewFile,BufRead *.ts,*.tsx setlocal filetype=typescript
" }}}

" deoplete {{{
" let g:deoplete#enable_at_startup = 1
" call deoplete#custom#option({
"             \ 'auto_complete_delay': 0,
"             \ 'smart_case': v:true,
"             \ 'delimiters': ['/', '.'],
"             \ })
" }}}

" denite {{{
" call denite#custom#var('file/rec', 'command',
"             \ ['rg', '--files', '--glob', '!.git'])
"
" call denite#custom#map(
"             \ 'insert',
"             \ '<C-j>',
"             \ '<denite:move_to_next_line>',
"             \ 'noremap'
"             \)
" call denite#custom#map(
"             \ 'insert',
"             \ '<C-k>',
"             \ '<denite:move_to_previous_line>',
"             \ 'noremap'
"             \)
" }}}

" nvim-typescript {{{
" autocmd FileType typescript nnoremap <buffer> <C-]> :TSTypeDef<CR>
" }}}

" LSP {{{
let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['typescript', 'javascript', 'javascript.jsx'],
        \ })
endif
" }}}
