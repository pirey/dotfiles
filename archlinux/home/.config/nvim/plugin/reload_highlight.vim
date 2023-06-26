" auto reload custom highlight after loading colorscheme
augroup ReloadHighlight
    autocmd!
    autocmd ColorScheme * runtime init/highlight.vim
augroup END
