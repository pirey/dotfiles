" TODO: need some tweaking
function! GitDimIgnoredFiles()
    let gitcmd = 'git -c color.status=false status -s --ignored'
    if exists('b:NERDTree')
        let root = b:NERDTree.root.path.str()
    else
        let root = './'
    endif
    let files = split(system(gitcmd.' '.root), '\n')

    call GitFindIgnoredFiles(files)
endfunction

function! GitFindIgnoredFiles(files)
    for file in a:files
        let pre = file[0:1]
        if pre == '!!'
            let ignored = split(file[3:], '/')[-1]
            exec 'syn match Comment #\<'.escape(ignored, '~').'\(\.\)\@!\># containedin=NERDTreeFile'
        endif
    endfor
endfunction

autocmd FileType nerdtree       :call GitDimIgnoredFiles()
