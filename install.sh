#!/bin/sh

set -e # -e: exit on error

if [ ! "$(command -v chezmoi)" ]; then
  sudo pacman -S chezmoi
fi

chezmoi init --apply https://github.com/sygint/dotfiles.git
chezmoi cd
git remote remove origin
git remote add origin git@github.com:SYGINT/dotfiles.git
