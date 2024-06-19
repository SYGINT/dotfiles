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

# Backup pacman.conf before edits...
echo "Backing up pacman.conf..."
sudo cp /etc/pacman.conf /etc/pacman.conf.bak

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

# Initialize chezmoi
echo "Initializing chezmoi..."
if [ ! "$(command -v chezmoi)" ]; then
  sudo pacman -S chezmoi --noconfirm
fi

# Setup git
if [ ! "$(command -v git)" ]; then
  echo "Installing git..."
  sudo pacman -S git --noconfirm
fi

# Pull down and setup dotfiles
echo "Initializing dotfiless..."
chezmoi init --apply https://github.com/sygint/dotfiles.git
chezmoi cd
git remote remove origin
git remote add origin git@github.com:SYGINT/dotfiles.git
