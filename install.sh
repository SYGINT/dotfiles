#!/bin/sh

set -e # -e: exit on error

# Update Repositories and Packages
sudo pacman -Syu

# Add needed packages
sudo pacman -S base-devel

# Add Arch support
sudo pacman -S artix-archlinux-support

# Edit pacman.d mirror list to include arch repos
sudo sed -i '$!N;s/\[galaxy\]\nInclude = \/etc\/pacman\.d\/mirrorlist/&\n\n\[extra\]\nInclude = \/etc\/pacman\.d\/mirrorlist-arch\n\n\[community\]\nInclude = \/etc\/pacman\.d\/mirrorlist-arch/;P;D' /etc/pacman.conf
sudo pacman -Sy

if [ ! "$(command -v chezmoi)" ]; then
  sudo pacman -S chezmoi
fi

chezmoi init --apply https://github.com/sygint/dotfiles.git
chezmoi cd
git remote remove origin
git remote add origin git@github.com:SYGINT/dotfiles.git
