" disable auto cursorline
let g:loaded_cursorline = 1

set laststatus=2
set statusline=\ %{StatuslineGit()}\ %m%{zoom#statusline()}\ %t%=--\ %l,%c%V\ of\ %L\ --\ %P"

""" statusline 'widget' functions {{{
function! StatuslineDiagnostic() abort
    let info = get(b:, 'coc_diagnostic_info', {})
    if empty(info) | return '' | endif
    let msgs = []
    if get(info, 'error', 0)
        call add(msgs, 'E' . info['error'])
    endif
    if get(info, 'warning', 0)
        call add(msgs, 'W' . info['warning'])
    endif
    return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction

function! StatuslineGit()
    let [a,m,r] = GitGutterGetHunkSummary()
    let gutter = printf('+%d ~%d -%d', a, m, r)
    let head = fugitive#head()
    return empty(head) ? '' : '[' . head . ' ' . gutter . ']'
endfunction
""" }}}

""" highlight {{{
function! s:statusline_highlight()
    if winnr('$') == 1
        " use subtle bg color if there's only one window
        hi StatusLine cterm=NONE ctermfg=8 ctermbg=0
    else
        " use distinctive bg color when there are more windows
        hi StatusLine cterm=NONE ctermfg=18 ctermbg=8
    endif
endfunction

augroup statusline_highlight
    autocmd!
    autocmd VimEnter,VimResized,WinEnter,WinLeave * call s:statusline_highlight()
augroup END
""" }}}
