" vim-go {{{
" disable `K` as lookup doc
let g:go_doc_keywordprg_enabled = 0
" }}}

" Bclose {{{
nnoremap <leader>x :Bclose<CR>
" }}}

" Tagbar {{{
nnoremap <leader>t :TagbarToggle<CR>

" support for typescript
" npm install --global git+https://github.com/Perlence/tstags.git
let g:tagbar_type_typescript = {
            \ 'ctagsbin' : 'tstags',
            \ 'ctagsargs' : '-f-',
            \ 'kinds': [
            \ 'e:enums:0:1',
            \ 'f:function:0:1',
            \ 't:typealias:0:1',
            \ 'M:Module:0:1',
            \ 'I:import:0:1',
            \ 'i:interface:0:1',
            \ 'C:class:0:1',
            \ 'm:method:0:1',
            \ 'p:property:0:1',
            \ 'v:variable:0:1',
            \ 'c:const:0:1',
            \ ],
            \ 'sort' : 0
            \ }
" }}}

" Git Gutter {{{
let g:gitgutter_map_keys = 0
let g:gitgutter_realtime = 0 " disable realtime update, in hope vim doesn't lag
let g:gitgutter_eager = 0
let g:gitgutter_max_signs = 250

nnoremap <leader>g :GitGutterToggle<CR>
nnoremap <leader>G :GitGutterLineHighlightsToggle<CR>
" }}}

" NERDTree {{{
nnoremap <silent> <leader>d :NERDTreeToggle<CR>
nnoremap <silent> <leader>D :NERDTreeFind<CR>
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let g:NERDTreeStatusline = " FILES"

" nerdtree-git-plugin {{{
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "M",
    \ "Staged"    : "S",
    \ "Untracked" : "+",
    \ "Renamed"   : "R",
    \ "Unmerged"  : "!",
    \ "Deleted"   : "D",
    \ "Dirty"     : "!",
    \ "Clean"     : "C",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
" }}}
" }}}

" NERDCommenter {{{
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" underscore (_) are treated as slash (/)
nmap <C-_> <plug>NERDCommenterToggle
vmap <C-_> <plug>NERDCommenterToggle
" }}}

" Indent Line {{{
nnoremap <leader>i :IndentLinesToggle<CR>
let g:indentLine_faster = 1
let g:indentLine_char = '·'
let g:indentLine_concealcursor=0
" }}}

" ALE (linter) {{{
if (v:version >= 800 && (has('python') || has('python3')))
    let g:ale_sign_error = '●'
    let g:ale_sign_warning = '●'
    let g:ale_lint_delay = 50
    let g:ale_sign_column_always = 1
    let g:ale_linters = {
                \'typescript': ['tsserver', 'tslint'],
                \'javascript': ['eslint'],
                \}
    let g:ale_fixers = {
                \'json': 'prettier',
                \'typescript': ['tslint'],
                \'javascript': ['eslint'],
                \}
    let g:ale_linters_explicit = 1
    let g:ale_fix_on_save = 1
    let g:ale_lint_on_enter = 1
    let g:ale_javascript_eslint_suppress_missing_config = 1

    " see why :h ale-completion-completopt-bug
    set completeopt=menu,menuone,preview,noselect,noinsert

    " custom highlight for ALE {{{
    highlight ALEError cterm=NONE ctermbg=18 ctermfg=6
    highlight ALEErrorSign cterm=NONE ctermbg=0 ctermfg=6
    highlight ALEWarning cterm=NONE ctermbg=18 ctermfg=4
    highlight ALEWarningSign cterm=NONE ctermbg=0 ctermfg=4
    " }}}
endif
" }}}

" vim-rest-console {{{
let g:vrc_allow_get_request_body = 1
let g:vrc_elasticsearch_support = 1
let g:vrc_curl_opts={
    \'--include': '',
    \'--location': '',
    \'--show-error': '',
    \'--silent': ''
    \}
" }}}

" Prettier {{{
let g:prettier#config#semi = 'false'
let g:prettier#exec_cmd_async = 1
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
" }}}

" Buftabline {{{
let g:buftabline_indicators = 1
" }}}

" Easytags {{{
let g:easytags_async = 1
" }}}

" vim-lsp {{{
let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['typescript', 'typescript.tsx'],
        \ })
endif

let g:lsp_signs_error = {'text': '●'}
let g:lsp_signs_warning = {'text': '●'}
" let g:lsp_signs_info = {'text': '●'}
let g:lsp_signs_hint = {'text': '●'}

highlight LspErrorText cterm=NONE ctermbg=0 ctermfg=6
highlight LspWarningText cterm=NONE ctermbg=NONE ctermfg=4
highlight LspHintText cterm=NONE ctermbg=NONE ctermfg=6
highlight LspInformationText cterm=NONE ctermbg=NONE ctermfg=6
autocmd FileType typescript,typescript.tsx nnoremap <buffer> <C-]> :LspDefinition<CR>
" }}}
