" slashmili/alchemist.vim {{{
let g:alchemist_mappings_disable = 1
" }}}

" posva/vim-vue {{{
let g:vue_pre_processors = []
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
" let NERDTreeMapOpenExpl = ''
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 1
let NERDTreeStatusline = ' FILES'
let NERDTreeDirArrowExpandable = ''
let NERDTreeDirArrowCollapsible = ''
let g:NERDTreeNodeDelimiter = "\u00a0"

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
let g:buftabline_show = 2
let g:buftabline_number = 2
let g:buftabline_indicators = 1
" }}}

" junegunn/fzf {{{
function! FloatingFZF()
  let width = float2nr(&columns * 1 / 3)
  let height = float2nr(&lines * 1 / 3)
  let opts = { 'relative': 'editor',
             \ 'row': (&lines - height) / 2,
             \ 'col': (&columns - width) / 2,
             \ 'width': width,
             \ 'height': height }

  let win = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
  call setwinvar(win, '&winhighlight', 'NormalFloat:Normal')
endfunction

" let g:fzf_layout = { 'window': 'call FloatingFZF()' }
let g:fzf_layout = { 'window': { 'width': 0.5, 'height': 0.5 } }
let $FZF_DEFAULT_OPTS = '--reverse --color=16,fg:8,bg:-1,fg+:7,bg+:-1,gutter:-1,pointer:4,info:-1,border:-1,prompt:-1,header:-1'
let $FZF_DEFAULT_COMMAND = 'rg --files-with-matches --hidden "." --glob "!.git"'
" }}}

" osyo-manga/vim-anzu {{{
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
" }}}

" fszymanski/fzf-gitignore {{{
let g:fzf_gitignore_no_maps = 1
" }}}

" neoclide/coc.nvim {{{
augroup coc_keymaps
    autocmd!

    " LSP
    autocmd FileType haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascript.jsx,typescript,typescript.tsx,typescriptreact nmap <buffer> <C-]> <Plug>(coc-definition)
    autocmd FileType haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascript.jsx,typescript,typescript.tsx,typescriptreact nmap <buffer> <c-^> <Plug>(coc-references)
    autocmd FileType haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascript.jsx,typescript,typescript.tsx,typescriptreact nmap <buffer> <leader>r <Plug>(coc-rename)
    autocmd FileType haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascript.jsx,typescript,typescript.tsx,typescriptreact nmap <buffer> <leader>a <Plug>(coc-codeaction)
    autocmd FileType haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascript.jsx,typescript,typescript.tsx,typescriptreact vmap <buffer> <leader>a <Plug>(coc-codeaction-selected)
    autocmd FileType haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascript.jsx,typescript,typescript.tsx,typescriptreact nmap <buffer> <leader>i <Plug>(coc-diagnostic-info)
    autocmd FileType haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascript.jsx,typescript,typescript.tsx,typescriptreact nmap <buffer> <leader>l :CocList<CR>
    autocmd FileType haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascript.jsx,typescript,typescript.tsx,typescriptreact nmap <buffer> <leader>e :CocList diagnostics<CR>
    autocmd FileType haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascript.jsx,typescript,typescript.tsx,typescriptreact nmap <buffer> <leader>o :CocList outline<CR>
    autocmd FileType haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascript.jsx,typescript,typescript.tsx,typescriptreact nmap <buffer> <leader>s :CocList --interactive symbols<CR>
    autocmd FileType haskell,ocaml,reason,c,cpp,h,go nmap <buffer> <leader>p :call CocAction('format')<CR>

    " snippets
    autocmd FileType haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascript.jsx,typescript,typescript.tsx imap <C-l> <Plug>(coc-snippets-expand)

    " Use <C-j> for jump to next placeholder, it's default of coc.nvim
    let g:coc_snippet_next = '<c-j>'
    " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
    let g:coc_snippet_prev = '<c-k>'
augroup END
" }}}

" aykamko/vim-easymotion-segments {{{
let g:EasyMotionSegments_key = 'w'
" }}}

" ripxorip/aerojump.nvim {{{
nmap <leader>as <Plug>(AerojumpSpace)
nmap <leader>ab <Plug>(AerojumpBolt)
nmap <leader>aa <Plug>(AerojumpFromCursorBolt)
nmap <leader>ad <Plug>(AerojumpDefault)
" }}}

" liuchengxu/vim-clap {{{
" experimental, this could replace fzf if mature enough
" can setup optimized keymaps for this later
let g:clap_layout = { 'relative': 'editor', 'width': '30%', 'col': '35%' }
let g:clap_current_selection_sign = { 'text': '> ', 'texthl': "ClapCurrentSelection", "linehl": "ClapCurrentSelection" }
let g:clap_selected_sign = { 'text': '> ', 'texthl': "ClapCurrentSelection", "linehl": "ClapCurrentSelection" }
" }}}

" ryanoasis/vim-devicons {{{
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '
" }}}
