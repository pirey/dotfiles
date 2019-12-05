#!/bin/sh

# haskell setup

( mkdir -p ~/.ghcup/bin && curl https://gitlab.haskell.org/haskell/ghcup/raw/master/ghcup > ~/.ghcup/bin/ghcup && chmod +x ~/.ghcup/bin/ghcup) && echo "Success"

ghcup install
ghcup set
ghcup install-cabal

cabal new-install cabal-install
