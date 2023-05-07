" neoclide/coc.nvim {{{
augroup coc_keymaps
    autocmd!

    " LSP
    autocmd FileType python,haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascriptreact,javascript.jsx,typescript,typescript.tsx,typescriptreact,rust nmap <buffer> <C-]> <Plug>(coc-definition)
    autocmd FileType python,haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascriptreact,javascript.jsx,typescript,typescript.tsx,typescriptreact,rust nmap <buffer> <c-^> <Plug>(coc-references)
    autocmd FileType python,haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascriptreact,javascript.jsx,typescript,typescript.tsx,typescriptreact,rust nmap <buffer> <space>r <Plug>(coc-rename)
    autocmd FileType python,haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascriptreact,javascript.jsx,typescript,typescript.tsx,typescriptreact,rust vmap <buffer> <space>a <Plug>(coc-codeaction-selected)
    autocmd FileType python,haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascriptreact,javascript.jsx,typescript,typescript.tsx,typescriptreact,rust nmap <buffer> <space>a <Plug>(coc-codeaction-line)
    autocmd FileType python,haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascriptreact,javascript.jsx,typescript,typescript.tsx,typescriptreact,rust nmap <buffer> <space>i <Plug>(coc-diagnostic-info)
    autocmd FileType python,haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascriptreact,javascript.jsx,typescript,typescript.tsx,typescriptreact,rust nmap <buffer> <space>e :CocDiagnostics<CR>
    " autocmd FileType python,haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascriptreact,javascript.jsx,typescript,typescript.tsx,typescriptreact,rust nmap <buffer> <space>o :CocList outline<CR>
    autocmd FileType python,haskell,ocaml,reason,c,cpp,h,php,go,json,javascript,javascriptreact,javascript.jsx,typescript,typescript.tsx,typescriptreact,rust nmap <buffer> <space>s :CocList --interactive symbols<CR>
    autocmd FileType python,haskell,ocaml,reason,c,cpp,h,php,go,rust nmap <buffer> <leader>p <Plug>(coc-format)
augroup END
" }}}


