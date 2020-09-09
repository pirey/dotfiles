if exists('g:loaded_lightline_explorer_pad')
  finish
endif

let g:loaded_lightline_explorer_pad = 1

call lightline#explorer_pad#init()
