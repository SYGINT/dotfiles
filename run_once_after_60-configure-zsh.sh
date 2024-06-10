#!/bin/sh

set -uo pipefail

source ~/.local/share/chezmoi/helpers.sh

TASK="Configuring Zsh"

log "$TASK"

[ ! -d ~/.zsh_plugins/zsh-defer ] && git clone https://github.com/romkatv/zsh-defer.git ~/.zsh_plugins/zsh-defer
[ ! -d ~/.zsh_plugins/zsh-fnm ] && git clone https://github.com/dominik-schwabe/zsh-fnm.git ~/.zsh_plugins/zsh-fnm
# [ ! -d ~/.zsh_plugins/zsh-nvm ] && git clone https://github.com/lukechilds/zsh-nvm.git ~/.zsh_plugins/zsh-nvm
[ ! -d ~/.zsh_plugins/zsh-autosuggestions ] && git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh_plugins/zsh-autosuggestions
[ ! -d ~/.zsh_plugins/zsh-syntax-highlighting ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh_plugins/zsh-syntax-highlighting
[ ! -d ~/.zsh_plugins/zsh-history-substring-search ] && git clone https://github.com/zsh-users/zsh-history-substring-search.git ~/.zsh_plugins/zsh-history-substring-search

log "Finished $TASK"
