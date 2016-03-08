## Setup vim
    First you need to install vundle: 
    ```git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    ```
    
    Copy or symlink `.vimrc` file inside dotfiles directory to your $HOME directory
    E.g `ln -s ./dotfiles/.vimrc ~/.vimrc`

    Then open vim, run command `:PluginInstall` to install listed plugins

    If you want to want to use custom configuration, create `.vimrc.local` in your $HOME directory

    My `.vimrc` file is well commented (I guess) so I recommend you to read it, and feel free to contact me if you have any question.
## Setup tmux
    all configuration does not need any aditional action, except for the plugin
    to use plugin: install tmux plugin manager (Optional)
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    in tmux session, `prefix + I` to install listed plugins
