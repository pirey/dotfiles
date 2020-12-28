" junegunn/fzf {{{
nnoremap <space><tab> :Maps<CR>
nnoremap <space>f :FZF<CR>
nnoremap <space>b :Buffers<CR>
nnoremap <space>h :History<CR>
nnoremap <space>w :Windows<CR>
" nnoremap <space>/ :Lines!<CR>
nnoremap <space>? :BLines<CR>

" git status with preview
nnoremap <space>gs :call fzf#vim#gitfiles('?', 1)<CR>
" git log all files
nnoremap <space>gl :call fzf#vim#commits(1)<CR>
" git log current file buffer
nnoremap <space>gbl :Glog -- %<CR>
" }}}

