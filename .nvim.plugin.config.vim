" denite {{{
nnoremap <C-p> :Denite buffer file/rec<CR>
nnoremap <leader>; :Denite command<CR>
nnoremap <leader>f :Denite grep<CR>
nnoremap <leader>/ :Denite line<CR>
if executable('rg')
  call denite#custom#var('file_rec', 'command', ['rg', '--files', '-F', '--color', 'never', '--hidden', '--glob', '!.git'])
  call denite#custom#var('file/rec', 'command', ['rg', '--files', '-F', '--color', 'never', '--hidden', '--glob', '!.git'])
  call denite#custom#var('grep',     'command', ['rg', '--glob', '!.git'])
  call denite#custom#var('grep',     'default_opts', ['--hidden', '--vimgrep', '--no-heading', '-S'])
  call denite#custom#var('grep',     'recursive_opts', [])
  call denite#custom#var('grep',     'final_opts',   [])
endif

call denite#custom#map(
            \ 'insert',
            \ '<C-j>',
            \ '<denite:move_to_next_line>',
            \ 'noremap'
            \)
call denite#custom#map(
            \ 'insert',
            \ '<C-k>',
            \ '<denite:move_to_previous_line>',
            \ 'noremap'
            \)
" }}}

" fruzzy {{{
let g:fruzzy#usenative = 1
let g:fruzzy#sortonempty = 1 " default value
call denite#custom#source('_', 'matchers', ['matcher/fruzzy'])
" }}}
