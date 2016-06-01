" Plugin Settings {{{
"
" PHP.vim {{{

function! PhpSyntaxOverride()
  hi! def link phpDocTags  phpDefine
  hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END

" }}}

" Buftabline {{{
let g:buftabline_indicators = 1
" }}}

" Syntastic {{{

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

nnoremap <leader><leader>s :SyntasticToggleMode<CR>

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" }}}

" Angular & Ionic syntastic ignore {{{

let g:syntastic_html_tidy_ignore_errors=["<ion-", "discarding unexpected </ion-",  'proprietary attribute "ng-', 'proprietary attribute "ng-']

" }}}

" Bclose {{{

nnoremap <leader>x :Bclose<CR>

" }}}

" Tagbar {{{

nnoremap <leader>t :TagbarToggle<CR>

" }}}

" Fugitive {{{
"set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
" }}}

" Git Gutter {{{

let g:gitgutter_realtime = 0 " disable realtime update, in hope vim doesn't lag
let g:gitgutter_eager = 0
let g:gitgutter_max_signs = 250
nnoremap <leader>g :GitGutterToggle<CR>
nnoremap <leader>G :GitGutterLineHighlightsToggle<CR>
" hunk stage = <leader>hs
" hunk revert stage (unstage) = <leader>hr

" }}}

" Vim Airline & Tmuxline {{{
"let g:airline#extensions#tabline#enabled =1 " enable tabline
"let g:airline#extensions#tabline#fnamemod = ':t' " show only the file name

" User patched font to display icons
"let g:airline_powerline_fonts = 1 

" If you don't have patched font installed, 
" I recommend using this setting for nice & simple appearance
"let g:airline_left_sep = ''
"let g:airline_right_sep = ''

" Tmuxline
"let g:tmuxline_powerline_separators = 1
"let g:airline#extensions#tmuxline#enabled = 0 " Use custom theme for tmuxline
"let g:tmuxline_theme = 'airline'
"let g:tmuxline_preset = 'full'

" }}}

" NERDTree {{{

nnoremap <silent> <leader>d :NERDTreeToggle<CR>
nnoremap <silent> <leader>D :NERDTreeFind<CR>
let NERDTreeShowHidden=1
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeStatusline = "FILES"

" }}}

" Emmet {{{
"
" }}}

" Surround {{{
"
" cs"'
" cs'<q>
" cst"
" ds"
" S<p class="something">
"
" }}}

" CtrlP {{{
"
" No need to reindex files when reopen CtrlP.
" to refresh search list, use <F5>
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_show_hidden = 1

if executable('ag')
  "let g:ctrlp_use_caching = 0
  let g:ctrlp_user_command = "ag --hidden --nocolor --ignore .git -l -g '' %s"
endif

" Status Line: {{{
" Arguments: focus, byfname, s:regexp, prv, item, nxt, marked
"            a:1    a:2      a:3       a:4  a:5   a:6  a:7
fu! CtrlP_main_status(...)
  let regex = a:3 ? '%2*regex %*' : ''
  let prv = '%#StatusLineNC# '.a:4.' %*'
  let item = ' ' . (a:5 == 'mru files' ? 'mru' : a:5) . ' '
  let nxt = '%#StatusLineNC# '.a:6.' %*'
  let byfname = '%2* '.a:2.' %*'
  let dir = '%#SLBranch# ← %*%#StatusLineNC#' . fnamemodify(getcwd(), ':~') . '%* '

  " only outputs current mode
  retu ' %#SLArrows#»%*' . item . '%#SLArrows#«%* ' . '%=%<' . dir

  " outputs previous/next modes as well
  " retu prv . '%4*»%*' . item . '%4*«%*' . nxt . '%=%<' . dir
endf
 
" Argument: len
"           a:1
fu! CtrlP_progress_status(...)
  let len = '%#Function# '.a:1.' %*'
  let dir = ' %=%<%#LineNr# '.getcwd().' %*'
  retu len.dir
endf

hi CtrlP_Purple  ctermfg=255 guifg=#ffffff  ctermbg=54  guibg=#5f5faf
hi CtrlP_IPurple ctermfg=54  guifg=#5f5faf  ctermbg=255 guibg=#ffffff
hi CtrlP_Violet  ctermfg=54  guifg=#5f5faf  ctermbg=104 guibg=#aeaed7

let g:ctrlp_status_func = {
  \ 'main': 'CtrlP_main_status',
  \ 'prog': 'CtrlP_progress_status'
  \}
" }}}

" }}}
" }}}
