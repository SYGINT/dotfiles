#!/usr/bin/zsh

set -eufo pipefail

source ~/.local/share/chezmoi/helpers.sh

TASK="Installing Node"

log "$TASK"

NODE_LTS=$(xidel https://nodejs.dev/en/download/ --extract "//div[contains(text(), 'LTS')]" | awk '{gsub(/v/,""); print $NF}')

HAS_NODEJS=$(asdf plugin list nodejs)

if [[ "$HAS_NODEJS" == "*" ]]; then
  asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
fi

asdf install nodejs $NODE_LTS
asdf global nodejs $NODE_LTS

# # Install PNPM
npm i -g pnpm
pnpm setup

log "Finished $TASK"
