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
nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)
nmap <leader>0 <Plug>BufTabLine.Go(10)

nmap <leader>0 <Plug>BufTabLine.Go(-1)
" }}}

" junegunn/fzf {{{
nmap <leader><tab> <plug>(fzf-maps-n)
nnoremap <space>f :FZF<CR>
nnoremap <space>b :Buffers<CR>
nnoremap <space>h :History<CR>
nnoremap <space>g :Commits<CR>
nnoremap <space>w :Windows<CR>
nnoremap <space>/ :BLines<CR>
nnoremap <space>? :Lines<CR>
" }}}

" neoclide/coc.nvim {{{
" }}}

" aykamko/vim-easymotion-segments {{{
" }}}

