if exists('g:neat_fold_loaded')
    finish
endif

let g:neat_fold_loaded = 1

set foldtext=neat_fold#NeatFoldText()
