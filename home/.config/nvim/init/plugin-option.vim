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
let g:fzf_preview_window = ''
" let g:fzf_win_resizer_width = 0.5
" let g:fzf_win_resizer_height = 0.5
" let g:fzf_layout = { 'window': { 'width': g:fzf_win_resizer_width, 'height': g:fzf_win_resizer_height } }
" let $FZF_DEFAULT_OPTS = '--reverse --color=16,fg:8,bg:-1,fg+:7,bg+:-1,gutter:-1,pointer:4,info:-1,border:-1,prompt:-1,header:-1'
" let $FZF_DEFAULT_COMMAND = 'rg --files-with-matches --hidden "." --glob "!.git"'

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
    autocmd FileType python,haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascript.jsx,typescript,typescript.tsx,typescriptreact,rust vmap <buffer> <space>a <Plug>(coc-codeaction-selected)
    autocmd FileType python,haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascript.jsx,typescript,typescript.tsx,typescriptreact,rust nmap <buffer> <space>a <Plug>(coc-codeaction-line)
    autocmd FileType python,haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascript.jsx,typescript,typescript.tsx,typescriptreact,rust nmap <buffer> <space>i <Plug>(coc-diagnostic-info)
    autocmd FileType python,haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascript.jsx,typescript,typescript.tsx,typescriptreact,rust nmap <buffer> <space>e :CocDiagnostics<CR>
    autocmd FileType python,haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascript.jsx,typescript,typescript.tsx,typescriptreact,rust nmap <buffer> <space>o :CocList outline<CR>
    autocmd FileType python,haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascript.jsx,typescript,typescript.tsx,typescriptreact,rust nmap <buffer> <space>s :CocList --interactive symbols<CR>
    autocmd FileType python,haskell,ocaml,reason,c,cpp,h,php,go,rust nmap <buffer> <leader>p <Plug>(coc-format)

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

" ryanoasis/vim-devicons {{{
let g:WebDevIconsTabAirLineAfterGlyphPadding = ' '
" }}}

" vim-airline/vim-airline {{{
let g:airline_section_c = '%m %t'

if g:colors_name == 'nord'
    let g:airline_theme='nord_subtle'
endif

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

let g:airline_filetype_overrides = {
            \ 'coc-explorer': [ 'EXPLORER', '' ],
            \ }


" extensions
let g:airline#extensions#capslock#enabled = 1

let g:airline#extensions#coc#enabled = 1
let airline#extensions#coc#error_symbol = '● '

let g:airline#extensions#branch#displayed_head_limit = 10
" let g:airline#extensions#branch#sha1_len = 10

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t:.'

" prevent airilne from overriding tmux conf
let g:airline#extensions#tmuxline#enabled = 0

" powerline symbols {{{
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'


"    
"    

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
"
" }}}

" hi StatusLine ctermbg=0
" }}}

" itchyny/lightline.vim {{{
let g:lightline = {
\   'colorscheme': 'nord_subtle',
\   'active': {
\    'left' :[[ 'mode', 'paste' ],
\             [ 'readonly' ],
\             [ 'filename', 'modified' ]],
\    'right':[[ 'filetype', 'percent', 'lineinfo' ] ]
\   },
\   'tab': {
\     'active': ['tabnum'],
\     'inactive': ['tabnum']
\   },
\   'tabline': {
\     'left': [['explorer_pad', 'buffers']],
\     'right': [['gitbranch', 'smarttabs']]
\   },
\   'separator': {
\     'left': '', 'right': ''
\   },
\   'subseparator': {
\     'left': '', 'right': ''
\   },
\   'component_function': {
\     'explorer_pad': 'LightlineCocExplorerLeftpad',
\     'percent': 'LightlinePercent',
\     'lineinfo': 'LightlineLineinfo',
\     'filename': 'LightlineFilename',
\     'mode': 'LightlineMode',
\     'gitbranch': 'LightlineFugitive',
\     'readonly': 'LightlineReadonly',
\     'modified': 'LightlineModified',
\     'filetype': 'LightlineFiletype',
\   },
\   'component_expand': {
\     'buffers': 'lightline#bufferline#buffers',
\     'smarttabs': 'SmartTabsIndicator',
\     'trailing': 'lightline#trailing_whitespace#component'
\   },
\   'component_type': {
\     'buffers': 'tabsel',
\     'trailing': 'warning'
\   }
\}

function! s:trim(maxlen, str) abort
    let trimed = len(a:str) > a:maxlen ? a:str[0:a:maxlen] . '..' : a:str
    return trimed
endfunction

let g:coc_explorer_open = 0

function! s:coc_explorer_is_open() abort
    return get(g:, 'coc_explorer_open', 0)
endfunction

function! s:coc_explorer_state(s) abort
    echom 'state ' . a:s
    let g:coc_explorer_open = a:s
endfunction

autocmd BufEnter *coc-explorer* call s:coc_explorer_state(1)
autocmd BufHidden *coc-explorer* call s:coc_explorer_state(0)

function! LightlineCocExplorerLeftpad() abort
    if &co < 86
        return ''
    endif

    if s:coc_explorer_is_open()
        return printf('%-29s', '') . '⎟'
    endif

    return ''
endfunction

function! LightlinePercent() abort
    if winwidth(0) < 60
        return ''
    endif

    let l:percent = line('.') * 100 / line('$') . '%'
    return printf('%-4s', l:percent)
endfunction

function! LightlineLineinfo() abort
    if winwidth(0) < 86
        return ''
    endif

    let l:current_line = printf('%-3s', line('.'))
    let l:max_line = printf('%-3s', line('$'))
    let l:lineinfo = ' ' . l:current_line . '/' . l:max_line
    return l:lineinfo
endfunction

function! LightlineFilename() abort
    let l:maxlen = winwidth(0) - winwidth(0) / 3
    let l:relative = @%
    let l:tail = expand('%:t')
    let l:noname = '[No Name]'

    if winwidth(0) < 50
        return ''
    endif

    if winwidth(0) < 86
        return l:tail ==# '' ? l:noname : s:trim(l:maxlen, l:tail)
    endif

    return l:relative ==# '' ? l:noname : s:trim(l:maxlen, l:relative)
endfunction

function! LightlineModified() abort
    return &modified ? '●' : ''
endfunction

function! LightlineMode() abort
    return &filetype ==# 'coc-explorer' ? 'EXPLORER' :
                \ &filetype ==# 'fugitive' ? 'FUGITIVE' :
                \ lightline#mode()
endfunction

function! LightlineReadonly() abort
    return &readonly ? '' : ''
endfunction

function! LightlineFugitive() abort
    if exists('*fugitive#head')
        let maxlen = 20
        let branch = fugitive#head()
        return branch !=# '' ? ' '. s:trim(maxlen, branch) : ''
    endif
    return fugitive#head()
endfunction

function! LightlineFiletype() abort
    let l:icon = WebDevIconsGetFileTypeSymbol()
    return winwidth(0) > 86 ? (strlen(&filetype) ? &filetype . ' ' . l:icon : l:icon) : ''
endfunction

function! String2()
    return 'BUFFERS'
endfunction

function! SmartTabsIndicator() abort
    let tabs = lightline#tab#tabnum(tabpagenr())
    let tab_total = tabpagenr('$')
    return tabpagenr('$') > 1 ? ('TABS ' . tabs . '/' . tab_total) : ''
endfunction

" autoreload
command! LightlineReload call LightlineReload()

function! LightlineReload() abort
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
endfunction

let g:lightline#trailing_whitespace#indicator = ''
" }}}

" mengelbrecht/lightline-bufferline {{{
set showtabline=2
let g:lightline#bufferline#unnamed = '[No Name]'
let g:lightline#bufferline#filename_modifier= ':.'
let g:lightline#bufferline#more_buffers = '...'
let g:lightline#bufferline#modified = ' ●'
let g:lightline#bufferline#read_only = ' '
let g:lightline#bufferline#shorten_path = 1
let g:lightline#bufferline#show_number = 0
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#unicode_symbols = 1
" }}}
" FooSoft/vim-argwrap {{{
nnoremap <silent> <space>zc :ArgWrap<CR>
" }}}

" pirey/nonu.vim {{{
let g:nonu_filetypes = ['git', 'gitcommit', 'fzf', 'fugitive', 'vim-plug', 'rest']
" }}}

" jwalton512/vim-blade {{{
" Define some single Blade directives. This variable is used for highlighting only.
let g:blade_custom_directives = ['csrf', 'method']

" Define pairs of Blade directives. This variable is used for highlighting and indentation.
let g:blade_custom_directives_pairs = {
            \   'error': 'enderror',
            \ }
" }}}

" rhysd/git-messenger.vim {{{
let g:git_messenger_no_default_mappings = 1
let g:git_messenger_always_into_popup = 1
let g:git_messenger_include_diff = 'current'
" }}}

" APZelos/blamer.nvim {{{
let g:blamer_enabled = 1
let g:blamer_delay = 1000
let g:blamer_prefix = '  '
let g:blamer_relative_time = 1
" }}}

let g:python_highlight_all = 1
