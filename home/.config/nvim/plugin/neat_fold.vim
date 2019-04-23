if exists('g:loaded_neat_fold')
    finish
endif

let g:loaded_neat_fold = 1

set foldtext=neat_fold#NeatFoldText()
