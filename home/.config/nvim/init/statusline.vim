" disable auto cursorline
let g:loaded_cursorline = 1

set laststatus=2
set statusline=\ %t\ %{GitStatus()}%=%{DiagnosticStatus()}\ --\ %l,%c%V\ of\ %L\ --\ %P"

function! DiagnosticStatus() abort
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

function! GitStatus()
    let [a,m,r] = GitGutterGetHunkSummary()
    let gutter = printf('+%d ~%d -%d', a, m, r)
    let fugitive = fugitive#head()
    return '[' . fugitive . ' ' . gutter . ']'
endfunction
