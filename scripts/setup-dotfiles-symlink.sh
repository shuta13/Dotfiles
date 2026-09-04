#!/bin/bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"

ln -sfn "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
ln -sfn "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sfn "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"
