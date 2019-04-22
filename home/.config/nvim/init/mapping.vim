let mapleader = ","

nnoremap ; :
vnoremap ; :

" Save a file as sudo when we forgot to start vim using sudo.
" nnoremap <leader>suw :w !sudo tee > /dev/null %<CR>

if has('nvim')
    " edit init.vim
    nnoremap <leader>v :e ~/.config/nvim/init.vim<CR>

    " reload init.vim
    nnoremap <leader><leader>v :source ~/.config/nvim/init.vim<CR>
else
    " Edit vimrc
    nnoremap <leader>v :e ~/.vimrc<CR>

    " reload vimrc
    nnoremap <leader><leader>v :source ~/.vimrc<CR>
endif

" Close current window
nnoremap <leader>w <C-w>c

" Open previous buffer
nnoremap <leader>b :b#<CR>

" Close current buffer, this will be improved by plugin called Bclose
nnoremap <leader>x :bd!<CR>
" Force close all buffers, clean things up!
nnoremap <leader><leader>x :bufdo bd!<CR>

" Command line
cnoremap <c-n>  <down>
cnoremap <c-p>  <up>

" Paste copied text (with y)  in command line
cnoremap <c-v> <c-r>"

" Shell

" select last pasted text
nnoremap gp `[v`]

nnoremap yp yyp
nnoremap yP yyP

" auto indent pasted text
" nice trick but problematic when pasting large text
" TODO disable auto indent only on html files
"nnoremap p p=`]
"nnoremap P P=`]

" go to end of line, but not really
vnoremap $ $h

" toggle list
nnoremap <leader>l :set list!<CR>
" toggle relative numbering
nnoremap <C-n> :set relativenumber!<CR>

" in visual mode, press * to search for selected text, instead of jumping the
" selection
vnoremap * y/<C-R>"<CR>
" auto turn off previous highlight when searching
nnoremap / :noh<cr>/

" auto center search item
nnoremap n nzz
nnoremap N Nzz

" toggle fold
nnoremap <space> za

" movement {{{
" faster horizontal scroll
nnoremap zh 20zh
nnoremap zl 20zl

" normalize up and down movement in wrapped line
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Now, this is my favorite part, jumping like a Ninja!

" jump to the left and right
nnoremap E 20l
nnoremap B 20h
vnoremap E 20l
vnoremap B 20h

" Semi soft scroll, scroll half the page
" nnoremap J <C-d>
" nnoremap K <C-u>
" vnoremap J <C-d>
" vnoremap K <C-u>

" Soft scroll, scroll 10 lines
nnoremap J 10gj
nnoremap K 10gk
vnoremap J 10gj
vnoremap K 10gk

" preserve cursor in the middle when scrolling
nnoremap <C-f> <C-f>M
nnoremap <C-b> <C-b>M


" Easier window movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <C-w>f <C-w>vgf
nnoremap <C-w>f <C-w>vgf
nnoremap <C-w><c-f> <C-w>vgf
" }}}
