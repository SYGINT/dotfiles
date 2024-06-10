#!/bin/sh

set -uo pipefail

universe="
[universe]
Server = https://universe.artixlinux.org/\$arch
Server = https://mirror1.artixlinux.org/universe/\$arch
Server = https://mirror.pascalpuffke.de/artix-universe/\$arch
Server = https://mirrors.qontinuum.space/artixlinux-universe/\$arch
Server = https://mirror1.cl.netactuate.com/artix/universe/\$arch
Server = https://ftp.crifo.org/artix-universe/\$arch
Server = https://artix.sakamoto.pl/universe/\$arch"

arch_repos="
[extra]
Include = /etc/pacman.d/mirrorlist-arch

[community]
Include = /etc/pacman.d/mirrorlist-arch"

# Update Repositories and Packages
sudo pacman -Syu

# Add needed packages
sudo pacman -S base-devel

# Add universe repos
echo "${universe}" | sudo tee -a /etc/pacman.conf
sudo pacman -Sy

# Add Arch support
sudo pacman -S artix-archlinux-support

sudo pacman-key --populate archlinux

# Edit pacman.d mirror list to include arch repos
# sudo sed -i '$!N;s/\[galaxy\]\nInclude = \/etc\/pacman\.d\/mirrorlist/&\n\n\[extra\]\nInclude = \/etc\/pacman\.d\/mirrorlist-arch\n\n\[community\]\nInclude = \/etc\/pacman\.d\/mirrorlist-arch/;P;D' /etc/pacman.conf
# sudo pacman -Sy

if [ ! "$(command -v chezmoi)" ]; then
  sudo pacman -S chezmoi
fi

chezmoi init --apply https://github.com/sygint/dotfiles.git
chezmoi cd
git remote remove origin
git remote add origin git@github.com:SYGINT/dotfiles.git
