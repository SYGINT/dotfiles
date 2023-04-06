#!/bin/sh

# Communications

sudo pacman -Syu \
  signal-desktop

# Web Browsers

sudo pacman -Syu \
  firefox \
  chromium \
  vivaldi \
  brave-bin

# File Browsers

sudo pacman -Syu \
  nemo

# Productivity

sudo pacman -Syu \
  obsidian

# Development

sudo pacman -Syu \
  vscodium \
  nvm 

# install and use node LTS

nvm install lts
nvm use lts

# install fisher

curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install jorgebucaran/nvm.fish