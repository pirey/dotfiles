## setup
+ clone
+ run `./install [<dotfiles_dir>]`, where `dotfiles_dir` is directory where you clone this repo (default is `~/.dotfiles`). it will create symlinks to home directory

## vim
+ First you need to install vundle: `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
+ Install plugins:
    - open vim, then run command `:PluginInstall` to install listed plugins

## tmux
+ All configuration does not need any aditional action, except for the plugin
+ To use plugin, install tmux plugin manager (Optional)
    - `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
    - In tmux session, `prefix + I` to install listed plugins
