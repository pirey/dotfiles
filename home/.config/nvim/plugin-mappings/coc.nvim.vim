" neoclide/coc.nvim {{{
nnoremap <space>? :CocSearch --hidden -S<space>
nnoremap <space>l :CocList<CR>
nnoremap <space>d :CocCommand explorer<CR>
nnoremap <leader>d :CocCommand explorer<CR>

" Map <c-l> for trigger completion, completion confirm, snippet expand and jump like VSCode.
" <control + l> is easier to reach after pressing <c-p> or <c-n> for pum selection
inoremap <silent><expr> <c-l>
            \ pumvisible() ? coc#_select_confirm() :
            \ coc#expandableOrJumpable() ?
            \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
            \ <SID>check_back_space() ? "\<c-l>" :
            \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" }}}

