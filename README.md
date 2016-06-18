## vim
+ First you need to install vundle: `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
<!--+ Copy or symlink `.vimrc` file inside dotfiles directory to your `$HOME` directory. E.g `ln -s ./dotfiles/.vimrc ~/.vimrc`-->
+ Make sure that you have `.vimrc` and `.vimrc.bundles` in your `$HOME` directory
    - `.vimrc` for main configuration
    - `.vimrc.bundles` for plugins listing and their settings
+ Install plugins:
    - open vim, then run command `:PluginInstall` to install listed plugins

## tmux
+ All configuration does not need any aditional action, except for the plugin
+ To use plugin, install tmux plugin manager (Optional)
    - `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
    - In tmux session, `prefix + I` to install listed plugins
