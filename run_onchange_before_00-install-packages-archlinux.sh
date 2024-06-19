#!/bin/sh

set -uo pipefail

source ~/.local/share/chezmoi/helpers.sh

if if ! command -v paru &> /dev/null; then
  sudo pacman -S --needed base-devel
  git clone https://aur.archlinux.org/paru.git
  cd paru
  makepkg -si
  cd ..
  rm -rf paru
fi

TASK="Installing Arch Packages"

log "$TASK"

archPackages=(
  # Communications
  cinny-desktop
  element-desktop
  # fluffychat #disabled
  konversation
  signal-desktop
  slack-desktop
  telegram-desktop
  wire-desktop

  # Code/Text Editors
  gedit
  lunarvim-git
  neovim
  sublime-text-4
  ted
  vim
  vscodium-bin # AUR
  # zed-editor

  # Development
  dbeaver
  docker
  docker-openrc
  docker-compose
  gittyup
  insomnium
  jetbrains-fleet
  lapce
  mongodb-compass
  python
  python-pip
  python-pipx
  python-wheel
  pocketbase-bin
  webstorm

  # Display Manager
  lightdm
  lightdm-gtk-greeter

  # File Browser
  filezilla
  nemo

  # Multimedia
  gimp
  inkscape

  # Productivity
  focalboard-bin
  libreoffice-fresh
  obsidian

  # Terminal
  alacritty
  guake
  terminator

  # Audio
  pipewire
  pipewire-audio
  pipewire-docs
  pipewire-pulse
  pipewire-openrc
  wireplumber
  wireplumber-openrc
  pavucontrol

  # Virtualization
  #playonlinux
  #wine-stable-next
  virtualbox
  virtualbox-guest-iso

  # Web Browsers
  chromium
  firefox
  google-chrome
  # librewolf
  microsoft-edge-stable-bin
  opera
  vivaldi
  brave-bin

  # Window Manager
  i3-wm
  i3status
  i3blocks
  i3lock

  # Utilities
  arandr
  asdf-vm
  archlinux-keyring
  baobab
  bluez
  bluez-utils
  bluez-openrc
  conky
  libwebp # convert to webp
  downgrade
  dunst
  engrampa
  flatpak
  fontforge
  gnome-disk-utility
  gnome-screenshot
  gnome-system-monitor
  grsync
  hardinfo
  htop
  inetutils
  linux-firmware
  lshw
  lsof
  mate-calc
  meld
  nemo-engrampa
  networkmanager
  network-manager-applet
  networkmanager-openrc
  nfs-utils
  nitrogen
  nm-connection-editor
  openslide
  p7zip
  p7zip-gui
  pacman-contrib # for rankmirrors
  peek
  polybar
  reflector
  rofi
  solaar
  syncthing
  syncthing-openrc
  synology-assistant
  tree
  unarchiver
  unzip
  # ufw
  wget
  xorg-xbacklight
  xorg-xinput
  xidel
)

for package in ${archPackages[@]}; do
  if [ "$(paru -Qq $package 2> /dev/null)" != $package ]; then
    echo "installing $package"
    paru -S $package
  fi
done

log "Finished $TASK"
