#!/bin/sh

set -eufo pipefail

source ~/.local/share/chezmoi/helpers.sh

if ! type "paru" > /dev/null; then
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
  signal-desktop
  slack-desktop
  konversation
  wire-desktop

  # Development
  vscodium # AUR
  insomnia-electron # AUR

  # Display Manager
  lightdm
  lightdm-gtk-greeter

  # Editors
  gedit
  vim

  # File Browser
  nemo

  # Multimedia
  gimp
  inkscape

  # Productivity
  obsidian

  # Terminal
  alacritty
  kitty
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
  virtualbox
  virtualbox-guest-iso

  # Web Browsers
  firefox
  chromium
  librewolf
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
  bluez
  bluez-utils
  bluez-openrc
  conky
  libwebp # convert to webp
  dunst
  engrampa
  # filezilla
  fontforge
  gedit
  gnome-disk-utility
  gnome-screenshot
  gnome-system-monitor
  grsync
  hardinfo
  inetutils
  linux-firmware
  lshw
  lsof
  meld
  nemo-engrampa
  networkmanager
  network-manager-applet
  networkmanager-openrc
  nitrogen
  nm-connection-editor
  openslide
  p7zip
  p7zip-gui
  pacman-contrib # for rankmirrors
  peek
  polybar
  python
  python-pip
  python-wheel
  reflector
  rofi
  solaar
  synology-assistant
  # synology-drive
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
