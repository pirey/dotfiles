" slashmili/alchemist.vim {{{
let g:alchemist_mappings_disable = 1
" }}}

" elmcast/vim-elm {{{
let g:elm_setup_keybindings = 0
" }}}

" fatih/vim-go {{{
" disable `K` as lookup doc
let g:go_doc_keywordprg_enabled = 0
" }}}

" chrismccord/bclose {{{
" }}}

" airblade/vim-gitgutter {{{
let g:gitgutter_map_keys = 0
let g:gitgutter_realtime = 0 " disable realtime update, in hope vim doesn't lag
let g:gitgutter_eager = 0
let g:gitgutter_max_signs = 250
" }}}

" scrooloose/nerdtree {{{
let g:NERDTreeNodeDelimiter = "\u00a0"
let NERDTreeMapOpenExpl = ''
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 1
let NERDTreeStatusline = ' FILES'
let NERDTreeDirArrowExpandable = ' '
let NERDTreeDirArrowCollapsible = ' '

" nerdtree-git-plugin {{{
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "M",
    \ "Staged"    : "S",
    \ "Untracked" : "+",
    \ "Renamed"   : "R",
    \ "Unmerged"  : "!",
    \ "Deleted"   : "D",
    \ "Dirty"     : "!",
    \ "Clean"     : "-",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
" }}}

" }}}

" scrooloose/nerdcommenter {{{
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" underscore (_) are treated as slash (/)
" }}}

" Yggdroot/indentLine {{{
let g:indentLine_faster = 1
let g:indentLine_char = '·'
let g:indentLine_concealcursor=0
" }}}

" diepm/vim-rest-console {{{
let g:vrc_allow_get_request_body = 1
let g:vrc_elasticsearch_support = 1
let g:vrc_curl_opts={
    \'--include': '',
    \'--location': '',
    \'--show-error': '',
    \'--silent': ''
    \}
" }}}

" prettier/vim-prettier {{{
let g:prettier#config#semi = 'false'
let g:prettier#exec_cmd_async = 1
let g:prettier#autoformat = 0
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
" }}}

" ap/vim-buftabline {{{
let g:buftabline_show = 1
let g:buftabline_indicators = 1
" }}}

" junegunn/fzf {{{
let $FZF_DEFAULT_OPTS = '--color=16,fg:8,bg:-1,fg+:7,bg+:-1,gutter:-1,pointer:4,info:-1,border:-1,prompt:-1,header:-1'
let $FZF_DEFAULT_COMMAND = 'rg --files-with-matches --hidden "." --glob "!.git"'
" }}}

" fszymanski/fzf-gitignore {{{
let g:fzf_gitignore_no_maps = 1
" }}}

" neoclide/coc.nvim {{{
augroup coc_keymaps
    autocmd!

    " LSP
    autocmd FileType php,go,json,javascript,javascript.jsx,typescript,typescript.tsx nmap <buffer> <C-]> <Plug>(coc-definition)
    autocmd FileType php,go,json,javascript,javascript.jsx,typescript,typescript.tsx nmap <buffer> <c-^> <Plug>(coc-references)
    autocmd FileType php,go,json,javascript,javascript.jsx,typescript,typescript.tsx nmap <buffer> <leader>r <Plug>(coc-rename)
    autocmd FileType php,go,json,javascript,javascript.jsx,typescript,typescript.tsx nmap <buffer> <leader>a <Plug>(coc-codeaction)
    autocmd FileType php,go,json,javascript,javascript.jsx,typescript,typescript.tsx vmap <buffer> <leader>a <Plug>(coc-codeaction-selected)
    autocmd FileType php,go,json,javascript,javascript.jsx,typescript,typescript.tsx nmap <buffer> <leader>i <Plug>(coc-diagnostic-info)
    autocmd FileType php,go,json,javascript,javascript.jsx,typescript,typescript.tsx nmap <buffer> <leader>l :CocList<CR>
    autocmd FileType php,go,json,javascript,javascript.jsx,typescript,typescript.tsx nmap <buffer> <leader>e :CocList diagnostics<CR>
    autocmd FileType php,go,json,javascript,javascript.jsx,typescript,typescript.tsx nmap <buffer> <leader>o :CocList outline<CR>
    autocmd FileType php,go,json,javascript,javascript.jsx,typescript,typescript.tsx nmap <buffer> <leader>s :CocList --interactive symbols<CR>
    autocmd FileType php,go nmap <buffer> <leader>p :call CocAction('format')<CR>

    " snippets
    autocmd FileType php,go,json,javascript,javascript.jsx,typescript,typescript.tsx imap <C-l> <Plug>(coc-snippets-expand)

    " Use <C-j> for jump to next placeholder, it's default of coc.nvim
    let g:coc_snippet_next = '<c-j>'
    " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
    let g:coc_snippet_prev = '<c-k>'
augroup END
" }}}

" aykamko/vim-easymotion-segments {{{
let g:EasyMotionSegments_key = 'w'
" }}}
