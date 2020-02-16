#!/bin/sh

echo "setup zsh..."

if [ ! -d ~/.oh-my-zsh ] ; then
	touch ~/.zshrc # prevent zsh initial greeting message
	echo "change default shell for current user ($(logname))..."
	chsh -s $(which zsh) $(logname)

    # fresh install
	# sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    # install manually, since we already have .zshrc
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
else
	echo "directory ~/.oh-my-zsh already exists..."
fi
