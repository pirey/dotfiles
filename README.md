## Setup vim
First you need to install vundle: 
`git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`

Copy or symlink `.vimrc` file inside dotfiles directory to your `$HOME` directory
E.g `ln -s ./dotfiles/.vimrc ~/.vimrc`

Then open vim, run command `:PluginInstall` to install listed plugins

There are currently two type of custom configuration
1. Global: create `.vimrc.custom` in your `$HOME` directory
2. Local (project configuration): create `.vimrc.local` inside the root of your project directory (open vim from project root directory)

My `.vimrc` file is well commented (I guess) so I recommend you to read it, and feel free to contact me if you have any question.

## Setup tmux
All configuration does not need any aditional action, except for the plugin

To use plugin: install tmux plugin manager (Optional)

`git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`

In tmux session, `prefix + I` to install listed plugins
