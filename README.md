## setup
+ `git clone https://github.com/pirey/dotfiles`
+ go to cloned directory, then `./install [<dotfiles_dir>]`, where `dotfiles_dir` is directory where you clone this repo (default is `~/.dotfiles`). it will create symlinks to home directory

## vim
+ install plugins:
    - open vim, then run command `:PlugInstall` to install listed plugins

## tmux
+ all configuration does not need any aditional action, except for the plugin
+ to use plugin, install tmux plugin manager (Optional)
    - `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
    - In tmux session, `prefix + I` to install listed plugins
