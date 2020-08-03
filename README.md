
## link config files
+ `git clone https://github.com/pirey/dotfiles`
+ go to cloned directory, then `./setup/link-config.sh [<dotfiles_dir>]`, where `dotfiles_dir` is directory where you clone this repo (default is `~/dotfiles`). **it will do these automatically for you**:
    - create symlinks for all necessary dotfiles to your home directory

## unlink config files
+ you can remove all symlinks generated by `install` step above, by calling `./setup/unlink-config.sh` inside your `dotfiles` directory

## tmux
+ all configuration does not need any aditional action, except for the plugin
+ to use plugin, install tmux plugin manager (Optional)
    - `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
    - In tmux session, `prefix + I` to install listed plugins


## arch linux

+ follow instruction from [here](https://gist.github.com/pirey/847c7a212db91d1337a35673d610f8ea)
+ `setup/arch/setup.sh`

## local config

### git

The ~/.gitconfig.local file will be automatically included after the configurations from ~/.gitconfig, thus, allowing its content to overwrite or add to the existing Git configurations.

Note: Use ~/.gitconfig.local to store sensitive information such as the Git user credentials, e.g.:

```
[user]
    name = Yuri
    email = work.email@studio.com
```
