#!/bin/sh

set -uo pipefail

arch="
[extra]
Include = /etc/pacman.d/mirrorlist-arch

[community]
Include = /etc/pacman.d/mirrorlist-arch"

# Update Repositories and Packages
echo "Updating repositories and packages..."
sudo pacman -Syu --noconfirm

# Add needed development packages
echo "Adding needed development packages..."
sudo pacman -S base-devel --noconfirm

# Add Arch linux repos
echo "Adding arch linux repositories..."
if ! grep -q "[extra]" /etc/pacman.conf; then
  echo "${arch}" | sudo tee -a /etc/pacman.conf
fi
sudo pacman -Sy --noconfirm

# Add Arch support
echo "Adding artix arch linux support package..."
sudo pacman -S artix-archlinux-support --noconfirm

# Add Arch keyring to database
echo "Adding arch linux keying to database..."
sudo pacman-key --populate archlinux

# Edit pacman.d mirror list to include arch repos
# sudo sed -i '$!N;s/\[galaxy\]\nInclude = \/etc\/pacman\.d\/mirrorlist/&\n\n\[extra\]\nInclude = \/etc\/pacman\.d\/mirrorlist-arch\n\n\[community\]\nInclude = \/etc\/pacman\.d\/mirrorlist-arch/;P;D' /etc/pacman.conf
# sudo pacman -Sy

if [ ! "$(command -v chezmoi)" ]; then
  sudo pacman -S chezmoi --noconfirm
fi

chezmoi init --apply https://github.com/sygint/dotfiles.git
chezmoi cd
git remote remove origin
git remote add origin git@github.com:SYGINT/dotfiles.git
