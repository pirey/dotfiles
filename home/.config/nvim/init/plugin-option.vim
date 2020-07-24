" slashmili/alchemist.vim {{{
" let g:alchemist_mappings_disable = 1
" }}}

" posva/vim-vue {{{
" let g:vue_pre_processors = []
" }}}

" elmcast/vim-elm {{{
" let g:elm_setup_keybindings = 0
" }}}

" fatih/vim-go {{{
" disable `K` as lookup doc
" let g:go_doc_keywordprg_enabled = 0
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
" let g:indentLine_concealcursor=0
" let g:indentLine_char = '│'
" let g:indentLine_color_term = 18
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
" set showtabline=2
" let g:buftabline_show = 2
" let g:buftabline_number = 2
" let g:buftabline_indicators = 1
" }}}

" liuchengxu/vim-clap {{{
" let g:clap_layout = { 'relative': 'editor', 'width': '30%', 'col': '35%' }
" let g:clap_layout = { 'relative': 'editor' }
" let g:clap_current_selection_sign = { 'text': '> ', 'texthl': "ClapCurrentSelection", "linehl": "ClapCurrentSelection" }
" let g:clap_selected_sign = { 'text': '> ', 'texthl': "ClapCurrentSelection", "linehl": "ClapCurrentSelection" }
" }}}

" junegunn/fzf {{{
let g:loaded_fzf_win_resizer = 1
" let g:fzf_win_resizer_width = 0.5
" let g:fzf_win_resizer_height = 0.5
" let g:fzf_layout = { 'window': { 'width': g:fzf_win_resizer_width, 'height': g:fzf_win_resizer_height } }
let $FZF_DEFAULT_OPTS = '--reverse --color=16,fg:8,bg:-1,fg+:7,bg+:-1,gutter:-1,pointer:4,info:-1,border:-1,prompt:-1,header:-1'
let $FZF_DEFAULT_COMMAND = 'rg --files-with-matches --hidden "." --glob "!.git"'

" NOTE:
" option above already set from environment variables, intentionally
" duplicated here until I acustomized to setting fzf config via env vars
" see $HOME/.env
" }}}

" neoclide/coc.nvim {{{
augroup coc_keymaps
    autocmd!

    " LSP
    autocmd FileType python,haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascript.jsx,typescript,typescript.tsx,typescriptreact,rust nmap <buffer> <C-]> <Plug>(coc-definition)
    autocmd FileType python,haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascript.jsx,typescript,typescript.tsx,typescriptreact,rust nmap <buffer> <c-^> <Plug>(coc-references)
    autocmd FileType python,haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascript.jsx,typescript,typescript.tsx,typescriptreact,rust nmap <buffer> <space>r <Plug>(coc-rename)
    autocmd FileType python,haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascript.jsx,typescript,typescript.tsx,typescriptreact,rust nmap <buffer> <space>a <Plug>(coc-codeaction)
    autocmd FileType python,haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascript.jsx,typescript,typescript.tsx,typescriptreact,rust vmap <buffer> <space>a <Plug>(coc-codeaction-selected)
    autocmd FileType python,haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascript.jsx,typescript,typescript.tsx,typescriptreact,rust nmap <buffer> <space>i <Plug>(coc-diagnostic-info)
    autocmd FileType python,haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascript.jsx,typescript,typescript.tsx,typescriptreact,rust nmap <buffer> <space>l :CocList<CR>
    autocmd FileType python,haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascript.jsx,typescript,typescript.tsx,typescriptreact,rust nmap <buffer> <space>E :CocList diagnostics<CR>
    autocmd FileType python,haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascript.jsx,typescript,typescript.tsx,typescriptreact,rust nmap <buffer> <space>e :CocDiagnostics<CR>
    autocmd FileType python,haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascript.jsx,typescript,typescript.tsx,typescriptreact,rust nmap <buffer> <space>o :CocList outline<CR>
    autocmd FileType python,haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascript.jsx,typescript,typescript.tsx,typescriptreact,rust nmap <buffer> <space>s :CocList --interactive symbols<CR>
    autocmd FileType python,haskell,ocaml,reason,c,cpp,h,php,go,rust nmap <buffer> <leader>p :call CocAction('format')<CR>

    " snippets
    autocmd FileType python,haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascript.jsx,typescript,typescript.tsx,rust imap <C-l> <Plug>(coc-snippets-expand)
augroup END

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
" }}}

" aykamko/vim-easymotion-segments {{{
let g:EasyMotionSegments_key = 'w'
" }}}

" ryanoasis/vim-devicons {{{
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '
let g:WebDevIconsTabAirLineAfterGlyphPadding = ' '
" }}}

" jremmen/vim-ripgrep {{{
let g:rg_command = 'rg --no-heading --vimgrep --hidden --glob "!.git"'
" }}}

" tpope/vim-fugitive {{{
" for small screen
" command! GST :10Gstatus
" }}}

" dhruvasagar/vim-zoom {{{
let g:zoom#statustext = '[Z]'
" }}}

" t9md/vim-choosewin {{{
let g:choosewin_overlay_enable = 1
" }}}

" vim-airline/vim-airline {{{
let g:airline_section_c = '%m %t'

if g:colors_name == 'nord'
    let g:airline_theme='nord_subtle'
endif

" powerline symbols
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
"
" let g:airline_left_sep = '' "
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = '' "''
" let g:airline_right_alt_sep = ''

" let g:airline_mode_map = {
"             \ '__'     : '-',
"             \ 'c'      : 'C',
"             \ 'i'      : 'I',
"             \ 'ic'     : 'I',
"             \ 'ix'     : 'I',
"             \ 'n'      : 'N',
"             \ 'multi'  : 'M',
"             \ 'ni'     : 'N',
"             \ 'no'     : 'N',
"             \ 'R'      : 'R',
"             \ 'Rv'     : 'R',
"             \ 's'      : 'S',
"             \ 'S'      : 'S',
"             \ ''     : 'S',
"             \ 't'      : 'T',
"             \ 'v'      : 'V',
"             \ 'V'      : 'V',
"             \ ''     : 'V',
"             \ }

" let g:airline_mode_map = {
"             \ '__'     : ' ',
"             \ 'c'      : ' ',
"             \ 'i'      : ' ',
"             \ 'ic'     : ' ',
"             \ 'ix'     : ' ',
"             \ 'n'      : ' ',
"             \ 'multi'  : ' ',
"             \ 'ni'     : ' ',
"             \ 'no'     : ' ',
"             \ 'R'      : ' ',
"             \ 'Rv'     : ' ',
"             \ 's'      : ' ',
"             \ 'S'      : ' ',
"             \ ''     : ' ',
"             \ 't'      : ' ',
"             \ 'v'      : ' ',
"             \ 'V'      : ' ',
"             \ ''     : ' ',
"             \ }

let g:airline#extensions#default#layout = [
            \ [ 'a', 'b', 'c' ],
            \ [ 'x', 'z', 'warning', 'error' ]
            \ ]

let g:airline#extensions#default#section_truncate_width = {
            \ 'b': 79,
            \ 'x': 88,
            \ 'y': 88,
            \ 'z': 60,
            \ 'warning': 90,
            \ 'error': 80,
            \ }

" extensions
let g:airline#extensions#capslock#enabled = 1

let g:airline#extensions#coc#enabled = 1
let airline#extensions#coc#error_symbol = '● '

let g:airline#extensions#branch#displayed_head_limit = 10
" let g:airline#extensions#branch#sha1_len = 10

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t:.'
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = ''
" let g:airline#extensions#tabline#right_sep = ''
" let g:airline#extensions#tabline#right_alt_sep = ''
"
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = ''
" let g:airline#extensions#tabline#right_sep = ''
" let g:airline#extensions#tabline#right_alt_sep = ''

let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''

" prevent airilne from overriding tmux conf
let g:airline#extensions#tmuxline#enabled = 0

" hi StatusLine ctermbg=0
" }}}

let g:python_highlight_all = 1
