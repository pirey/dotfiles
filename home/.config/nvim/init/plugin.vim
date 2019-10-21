" Language & Syntax {{{
" elixir {{{
Plug 'elixir-editors/vim-elixir', {'for': 'elixir' }
Plug 'slashmili/alchemist.vim', { 'for': 'elixir' }
" }}}

" js / ts {{{
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'HerringtonDarkholme/yats.vim', { 'for': ['typescript', 'typescript.tsx'] }
Plug 'purescript-contrib/purescript-vim', { 'for': 'purescript' }
Plug 'mustache/vim-mustache-handlebars', { 'for': 'html.handelbars' }
" }}}

" php {{{
Plug 'StanAngeloff/php.vim', { 'for': 'php' }                                   " PHP
Plug 'jwalton512/vim-blade', { 'for': 'php' }                                  " Laravel's Blade
Plug 'captbaritone/better-indent-support-for-php-with-html', { 'for': 'php' }
" }}}
" elm {{{
Plug 'elmcast/elm-vim', { 'for': 'elm' }
" }}}
" go {{{
" Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }
" }}}
" haskell
Plug 'itchyny/vim-haskell-indent', { 'for': 'haskell' }                             " haskell
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'Twinside/vim-hoogle', { 'for': 'haskell' }
Plug 'alx741/vim-hindent', { 'for': 'haskell' }
" }}}

" nginx {{{
Plug 'chr4/nginx.vim'
" }}}

" Colorscheme {{{
Plug 'chriskempson/base16-vim'
" }}}

" UI {{{
Plug 'ap/vim-buftabline'                                    " Show buffer name on top of screen
Plug 'Yggdroot/indentLine'
Plug 'chrisbra/unicode.vim'
" }}}

" Editing {{{
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'tpope/vim-capslock'                                     " <c-g>c use CAPSLOCK
Plug 'scrooloose/nerdcommenter'                               " Commenter `<leader>c<space>`
Plug 'mattn/emmet-vim'                                        " Emmet for vim `<c-y>,`
Plug 'tpope/vim-repeat'                                       " Repeat last plugin command
Plug 'tpope/vim-surround'                                     " Surrounder `cs*`
Plug 'godlygeek/tabular'                                      " Aligning tool :Tabular /{pattern}
Plug 'chrisbra/NrrwRgn'                                       " edit selected text to a new window
Plug 'Olical/vim-enmasse'                                     " Edit all files in the quickfix list
Plug 'editorconfig/editorconfig-vim'                          " Editor config
" }}}

" completion / snippets / intellisense {{{
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tslint-plugin', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/jsonc.vim', {'for': 'jsonc'}

Plug 'honza/vim-snippets'
Plug 'epilande/vim-es2015-snippets'
Plug 'justinj/vim-react-snippets'
" }}}

" navigation {{{
Plug 'vim-scripts/BufOnly.vim'                                " Close all buffer but current one.
Plug 'easymotion/vim-easymotion'                              " Jumping over places <leader><leader>w
Plug 'aykamko/vim-easymotion-segments'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }       " File browser <leader>d
Plug 'chrismccord/bclose.vim'                                 " Close a buffer without closing split window
Plug 'tpope/vim-unimpaired'                                   " pairs of handy bracket mappings
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" }}}

" Git {{{
Plug 'tpope/vim-fugitive'                                     		" Git wrapper
Plug 'junegunn/gv.vim'                                        		" Git commit browser
Plug 'airblade/vim-gitgutter'                                 		" Git changes sign
Plug 'Xuyuanp/nerdtree-git-plugin'                            		" Git status within nerdtree
Plug 'fszymanski/fzf-gitignore', {'do': ':UpdateRemotePlugins'} 	" .gitignore generator
" }}}

" ETC {{{
Plug 'diepm/vim-rest-console'                                 " making rest api call
Plug 'vim-utils/vim-man'                                      " View other program's manual page in vim :Man
Plug 'metakirby5/codi.vim'                                    " vscode's quokka.js in vim
Plug 'wakatime/vim-wakatime'
" }}}

" Search {{{
if executable('rg')
    Plug 'jremmen/vim-ripgrep'                                " ripgrep https://github.com/BurntSushi/ripgrep
else
    echo 'woy, why not have the rg ah?'
endif
" }}}
