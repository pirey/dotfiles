## setup
+ `git clone https://github.com/pirey/dotfiles`
+ go to cloned directory, then `./install [<dotfiles_dir>]`, where `dotfiles_dir` is directory where you clone this repo (default is `~/.dotfiles`). it will create symlinks to home directory

## vim
+ Install plugin manager, I use [vim-plug](https://github.com/junegunn/vim-plug):
    - `curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`

+ Install plugins:
    - open vim, then run command `:PluginInstall` to install listed plugins

## tmux
+ All configuration does not need any aditional action, except for the plugin
+ To use plugin, install tmux plugin manager (Optional)
    - `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
    - In tmux session, `prefix + I` to install listed plugins
