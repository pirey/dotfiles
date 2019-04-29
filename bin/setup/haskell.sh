# ========================
# HASKELL
echo "Setup Haskell environment..."
( mkdir -p ~/.ghcup/bin && curl https://raw.githubusercontent.com/haskell/ghcup/master/ghcup > ~/.ghcup/bin/ghcup && chmod +x ~/.ghcup/bin/ghcup) && echo "Success"
ghcup install
ghcup set
ghcup install-cabal
cabal new-install cabal-install

# require sudo access upfront
sudo -v

# bug of ghcup, requires to download libnuma manually
apt install libnuma-dev -y
echo "Done..."

# Haskell IDE Engine
echo "Setup Haskell IDE Engine..."
apt install libicu-dev libtinfo-dev libgmp-dev
mkdir -p $HOME/tools/
git clone https://github.com/haskell/haskell-ide-engine --recurse-submodules $HOME/tools/haskell-ide-engine
cd $HOME/tools/haskell-ide-engine
cabal new-install .
cd -
echo "Done..."

# common tools/packages
echo "Installing common tools..."
cabal new-install hindent
echo "Done..."
