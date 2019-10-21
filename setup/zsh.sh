#!/bin/sh

echo "setup zsh..."

if [ ! -d ~/.oh-my-zsh ] ; then
	touch ~/.zshrc # prevent zsh initial greeting message
	echo "change default shell for current user ($(logname))..."
	chsh $(logname) -s $(which zsh)
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
	echo "directory ~/.oh-my-zsh already exists..."
fi
