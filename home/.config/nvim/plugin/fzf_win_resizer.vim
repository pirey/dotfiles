if exists('g:loaded_fzf_win_resizer')
    finish
endif

let g:loaded_fzf_win_resizer = 1

" when window is too narrow, make sure to expand fzf width to full width
function! FZFSetWinSize()
  let min_column = 100
  let min_line = 30
  let width_default = 0.5
  let height_default = 0.5
  let width_full = 0.9
  let height_full = 0.9
  let width = &columns < min_column ? width_full : width_default
  let height = &lines < min_line ? height_full : height_default

  " reset the fzf win size
  let g:fzf_layout = { 'window': { 'width': width, 'height': height } }
endfunction

augroup fzf_win_resize
    autocmd!
    autocmd VimResized * call FZFSetWinSize()
    autocmd VimEnter * call FZFSetWinSize()
augroup END

