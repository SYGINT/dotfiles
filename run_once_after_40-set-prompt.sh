#!/bin/sh

set -uo pipefail

source ~/.local/share/chezmoi/helpers.sh

TASK="Installing Starship Prompt"

log "$TASK"

# Install nerd font
package="ttf-firacode-nerd"
if [ "$(paru -Qq $package 2> /dev/null)" != $package ]; then
  paru -S $package
fi

# Install Starship
curl -sS https://starship.rs/install.sh | sh

log "Finished $TASK"
