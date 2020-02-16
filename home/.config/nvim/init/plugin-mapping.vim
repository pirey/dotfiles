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

" liuchengxu/vim-clap {{{
" nnoremap <space><space> :Clap<CR>
" nnoremap <space>f :Clap files \+\+finder='rg --files-with-matches --hidden --glob "!.git" "."'<CR>
" nnoremap <space>b :Clap buffers \+\+finder='rg --files-with-matches --hidden --glob "!.git" "."'<CR>
" nnoremap <space>h :Clap history \+\+finder='rg --files-with-matches --hidden --glob "!.git" "."'<CR>
" nnoremap <space>w :Clap windows \+\+finder='rg --files-with-matches --hidden --glob "!.git" "."'<CR>
" nnoremap <space>g :Clap commits \+\+finder='rg --files-with-matches --hidden --glob "!.git" "."'<CR>
" nnoremap <space>/ :Clap blines \+\+finder='rg --files-with-matches --hidden --glob "!.git" "."'<CR>
" nnoremap <space><tab> :Clap maps<CR>
" }}}

" junegunn/fzf {{{
nnoremap <space><tab> :Maps<CR>
nnoremap <space>f :FZF<CR>
nnoremap <space>b :Buffers<CR>
nnoremap <space>h :History<CR>
nnoremap <space>w :Windows<CR>
nnoremap <space>/ :BLines<CR>
nnoremap <space>? :Lines<CR>

" fullscreen for better preview
nnoremap <space>gs :call fzf#vim#gitfiles('?', 1)<CR>
nnoremap <space>gl :call fzf#vim#commits(1)<CR>
" }}}

" neoclide/coc.nvim {{{
" }}}

" aykamko/vim-easymotion-segments {{{
" }}}

" osyo-manga/vim-anzu {{{
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
" }}}

" ripxorip/aerojump.nvim {{{
nmap <leader>as <Plug>(AerojumpSpace)
nmap <leader>ab <Plug>(AerojumpBolt)
nmap <leader>aa <Plug>(AerojumpFromCursorBolt)
nmap <leader>ad <Plug>(AerojumpDefault)
" }}}

