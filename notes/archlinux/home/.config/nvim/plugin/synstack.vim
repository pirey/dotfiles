" Shows syntax highlighting groups for the current cursor position
if exists('g:loaded_synstack')
    finish
endif

let g:loaded_synstack = 1

nmap <leader>sk :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
