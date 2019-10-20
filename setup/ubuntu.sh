#!/bin/sh

######################################
# tested on ubuntu 18.04 bionic beaver
######################################

setupdir=$(dirname "${0}") 

# configure keyboard delay speed
# swap capslock to escape

# apt packages
echo "installing apt packages..."
sudo -S apt -y install git zsh neovim tmux curl ripgrep

# php
sudo -S apt -y install php php-xml php-mbstring php-bcmath php-pgsql php-xml php-json php-tokenizer php-mysql
"${setupdir}"/composer.sh
if [ -f ./composer ]; then
	sudo -S mv composer /usr/local/bin
fi

# setup zsh
echo "setup zsh..."
if [ ! -d ~/.oh-my-zsh ] ; then
	touch ~/.zshrc # prevent zsh initial greeting
	echo "change default shell for current user ($(logname))..."
	chsh $(logname) -s $(which zsh)
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
	echo "directory ~/.oh-my-zsh already exists..."
fi

# nodejs
"${setupdir}"/nodejs.sh

# base16
if [ ! -d ~/.config/base16-shell ]; then
    git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
fi

# installing dotfiles
if [ ! -d ~/dotfiles ]; then
    # TODO dynamic repo
    # make sure ssh key is already setup for github access
    git clone git@github.com:pirey/dotfiles.git ~/dotfiles
fi





# i3 specifics
# install light (xbacklight alternative)
