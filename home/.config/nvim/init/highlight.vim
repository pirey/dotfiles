" Different highlight for different color mode
if has('termguicolors')
    hi TablineFill guibg=NONE

    " NORD
    hi EndOfBuffer guifg=#2E3440
    hi StatusLine guibg=#3B4252
    hi StatusLineNC guibg=#3B4252
    hi Visual guibg=#3B4252

    hi NERDTreeCWD guifg=#2E3440
else
    " chriskempson/base16-vim {{{
    hi Normal cterm=NONE ctermbg=NONE
    hi EndOfBuffer ctermfg=0
    hi SignColumn cterm=NONE ctermbg=NONE
    hi VertSplit cterm=NONE ctermbg=NONE ctermfg=18

    hi NonText ctermfg=NONE
    hi LineNr ctermfg=NONE ctermbg=NONE
    hi Visual ctermbg=18 ctermfg=NONE
    hi CursorLine ctermbg=18 ctermfg=NONE
    hi FoldColumn cterm=NONE ctermbg=NONE ctermfg=6
    hi Folded ctermbg=NONE

    " clearer statusline
    hi StatusLineNC cterm=NONE ctermfg=8 ctermbg=18
    if exists('g:loaded_airline')
        hi StatusLine ctermbg=0
    else
        hi StatusLine cterm=NONE ctermfg=7 ctermbg=18
    endif


    " simpler statusline
    " hi StatusLine cterm=NONE ctermfg=8 ctermbg=18
    " hi StatusLineNC cterm=NONE ctermfg=8 ctermbg=NONE

    hi Search cterm=NONE ctermfg=NONE ctermbg=18
    hi ColorColumn cterm=NONE ctermfg=NONE ctermbg=18
    "}}}

    " airblade/vim-gitgutter {{{
    hi GitGutterAdd ctermfg=2 ctermbg=NONE
    hi GitGutterChange ctermfg=4 ctermbg=NONE
    hi GitGutterChangeDelete ctermfg=5 ctermbg=NONE
    hi GitGutterDelete ctermfg=1 ctermbg=NONE
    " }}}

    " ap/vim-buftabline {{{
    hi BufTabLineCurrent ctermbg=18 ctermfg=7
    hi BufTabLineActive ctermbg=NONE ctermfg=8
    hi BufTabLineHidden ctermbg=NONE ctermfg=8
    hi BufTabLineFill cterm=NONE ctermbg=NONE
    hi TabLineFill cterm=NONE ctermbg=NONE
    " }}}

    " neoclide/coc.nvim {{{
    hi CocErrorSign cterm=NONE ctermbg=NONE ctermfg=6
    hi CocErrorHighlight cterm=NONE ctermbg=18 ctermfg=6
    hi CocWarningSign cterm=NONE ctermbg=NONE ctermfg=4
    hi CocInfoSign cterm=NONE ctermbg=NONE ctermfg=8
    hi CocHintSign cterm=NONE ctermbg=NONE ctermfg=8
    hi CocCodeLens ctermfg=18
    " }}}

    " scrooloose/nerdtree {{{
    hi NERDTreeCWD cterm=NONE ctermbg=NONE ctermfg=0
    hi NerdTreeFlags ctermfg=4
    " }}}

    " numirias/semshi {{{
    hi semshiImported ctermfg=7
    " }}}
endif
