if exists('g:loaded_fzf_win_resizer')
    finish
endif

let g:loaded_fzf_win_resizer = 1

" when window is too narrow, make sure to expand fzf width to full width
function! FZFSetWinSize()
  let min_bound = 100
  let width_default = 0.5
  let width_full = 1
  let width = &columns < min_bound ? width_full : width_default

  " reset the fzf win size
  let g:fzf_layout = { 'window': { 'width': width, 'height': 0.5 } }
endfunction

augroup fzf_win_resize
    autocmd!
    autocmd VimResized * call FZFSetWinSize()
    autocmd VimEnter * call FZFSetWinSize()
augroup END

