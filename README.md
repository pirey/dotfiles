## Note
    Copy or symlink needed files inside dotfiles directory to appropriate directory
    e.g `ln -s ./dotfiles/.vimrc ~/.vimrc`
## Setup vim:
    first you need to install vundle: 
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    
    then open vim, run command `:PluginInstall` to install listed plugins

    if you want to want to use `solarized` colorscheme, copy or symlink `.vimrc.solarized` file to your $HOME directory
## Setup tmux:
    all configuration does not need any aditional action, except for the plugin
    to use plugin: install tmux plugin manager (Optional)
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    in tmux session, `prefix + I` to install listed plugins
