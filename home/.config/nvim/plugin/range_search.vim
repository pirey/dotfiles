if exists('g:range_search_loaded')
    finish
endif

let g:range_search_loaded = 1

vnoremap <silent> / :<C-U>call range_search#RangeSearch('/')<CR>:if strlen(g:srchstr) > 0\|exec '/'.g:srchstr\|endif<CR>
vnoremap <silent> ? :<C-U>call range_search#RangeSearch('?')<CR>:if strlen(g:srchstr) > 0\|exec '?'.g:srchstr\|endif<CR>
