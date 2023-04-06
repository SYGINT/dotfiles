#!/bin/sh

set -e # -e: exit on error

if [ ! "$(command -v chezmoi)" ]; then
  sudo pacman -S chezmoi
fi