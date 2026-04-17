function! Tabline() abort
  let s = ''
  let cur = tabpagenr()

  for i in range(1, tabpagenr('$'))
    let hl = (i == cur) ? '%#TabLineSel#' : '%#TabLine#'
    let s .= hl . '%' . i . 'T ' . i . ' %T'
  endfor

  return s . '%#Normal#'
endfunction

set tabline=%!Tabline()
