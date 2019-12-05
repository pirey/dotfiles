#!/bin/sh

########################
# HASKELL setup script
########################

# NOTE this is for ubuntu 16.04 (outdated)

echo "Setup Haskell environment..."
( mkdir -p ~/.ghcup/bin && curl https://raw.githubusercontent.com/haskell/ghcup/master/ghcup > ~/.ghcup/bin/ghcup && chmod +x ~/.ghcup/bin/ghcup) && echo "Success"
ghcup install
ghcup set
ghcup install-cabal
cabal new-install cabal-install

# bug of ghcup, requires to download libnuma manually
sudo -S apt install libnuma-dev -y
echo "Done..."

# Haskell IDE Engine
echo "Setup Haskell IDE Engine..."
sudo -S apt install libicu-dev libtinfo-dev libgmp-dev -y
mkdir -p $HOME/.local/opt/haskell/
git clone https://github.com/haskell/haskell-ide-engine --recurse-submodules $HOME/.local/opt/haskell/haskell-ide-engine
cd $HOME/.local/opt/haskell/haskell-ide-engine
cabal new-install .
cd -
echo "Done..."

# common tools/packages
echo "Installing common tools..."
cabal new-install hindent hoogle
echo "Done..."
