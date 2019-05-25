" slashmili/alchemist.vim {{{
" }}}

" elmcast/vim-elm {{{
" }}}

" fatih/vim-go {{{
" disable `K` as lookup doc
" }}}

" chrismccord/bclose {{{
nnoremap <leader>x :Bclose<CR>
" }}}

" airblade/vim-gitgutter {{{
nnoremap <leader>g :GitGutterToggle<CR>
nnoremap <leader>G :GitGutterLineHighlightsToggle<CR>
nnoremap ]g :GitGutterNextHunk<CR>
nnoremap [g :GitGutterPrevHunk<CR>
" }}}

" scrooloose/nerdtree {{{
nnoremap <silent> <leader>d :NERDTreeToggle<CR>
nnoremap <silent> <leader>D :NERDTreeFind<CR>

" nerdtree-git-plugin {{{
" }}}
" }}}

" scrooloose/nerdcommenter {{{
" underscore (_) are treated as slash (/)
nmap <C-_> <plug>NERDCommenterToggle
vmap <C-_> <plug>NERDCommenterToggle
" }}}

" Yggdroot/indentLine {{{
nnoremap <leader><leader>i :IndentLinesToggle<CR>
" }}}

" diepm/vim-rest-console {{{
" }}}

" prettier/vim-prettier {{{
" }}}

" ap/vim-buftabline {{{
" }}}

" junegunn/fzf {{{
nmap <leader><tab> <plug>(fzf-maps-n)
nnoremap <c-p> :FZF<CR>
nnoremap <c-b> :Buffers<CR>
nnoremap <leader>/ :BLines<CR>
nnoremap <leader>? :Lines<CR>
" }}}

" neoclide/coc.nvim {{{
" }}}

" aykamko/vim-easymotion-segments {{{
" }}}

