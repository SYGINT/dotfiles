#!/bin/sh

set -uo pipefail

source ~/.local/share/chezmoi/helpers.sh

TASK="Configuring rofi"

log "$TASK"

sudo cp ~/.local/share/chezmoi/dot_config/rofi/dracula.rasi /usr/share/rofi/themes

log "Finished $TASK"

