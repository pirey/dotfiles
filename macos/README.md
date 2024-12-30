# Personal MacOS configuration notes

## install applications

- alacritty
- microsoft edge
- chrome
- firefox
- shortcat
- localsend

### open unverified app (e.g. alacritty)

- open app
- warning popup will appear
- open system settings > privacy & security > open anyway the specified app

### safari

- adguard

## setup cli tools (e.g. git, clang, etc)

- xcode-select --install

## install font

- blex mono nerd font

## setup keyboard

- install karabiner elements
- grant permission: settings > general > login items & extensions
- enable karabiner agents and daemon and driver extension
- add complex rule > import rule `e0da capslock`

## setup github ssh

```bash
ssh-keygen -t rsa -b 4096 -C "mail@host.com"
```

## setup neovim

- download nvim release
- clone nvim config repo

## setup dotfiles

## desktop & dock

- reduce dock size
- double-click a window's title bar to: fill
- automatically hide and show the dock: enable
- show suggested and recent apps in dock: disable
- hot corner: assign launchpad to top-left corner

## disable autocorrect

- spelling and prediction > disable items

## finder

- finder > settings > sidebar > enable items

## docker

install

```bash
brew install colima docker docker-compose
```

run hello world

```bash
colima start
docker run -d -p 8080:80 nginx
```

setup docker-compose

```bash
mkdir -p ~/.docker/cli-plugins
ln -sfn $(brew --prefix)/opt/docker-compose/bin/docker-compose ~/.docker/cli-plugins/docker-compose

# reload shell and test it
docker compose
```
