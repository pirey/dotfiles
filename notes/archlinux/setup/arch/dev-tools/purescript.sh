#!/bin/sh

echo "======================================"
echo "Installing purescript..."
echo "======================================"

# depends on nodejs & npm

if ! command -v npm &> /dev/null
then
    echo "Could not install purescript: missing nodejs / npm."
    exit
fi

# also depends on ncurses5

key=C52048C0C0748FEE227D47A2702353E0F7E48EDB # Thomas Dickey
gpg --keyserver pool.sks-keyservers.net --recv-keys $key

git clone https://aur.archlinux.org/ncurses5-compat-libs.git --depth=1 /tmp/ncurses5-aur
cd /tmp/ncurses5-aur
makepkg -si --noconfirm
cd -

npm i -g purescript spago
