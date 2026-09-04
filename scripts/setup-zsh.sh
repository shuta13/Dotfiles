#!/bin/bash

set -euo pipefail

mkdir -p "$HOME/.zsh"

curl -fsSL -o "$HOME/.zsh/git-prompt.sh" https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
curl -fsSL -o "$HOME/.zsh/git-completion.bash" https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
curl -fsSL -o "$HOME/.zsh/git-completion.zsh" https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh

# homebrew で入れる
# curl -o ~/.zsh/zsh-autosuggestions.zsh https://raw.githubusercontent.com/zsh-users/zsh-autosuggestions/master/zsh-autosuggestions.zsh
# curl -o ~/.zsh/zsh-syntax-highlighting https://raw.githubusercontent.com/zsh-users/zsh-syntax-highlighting/master/zsh-syntax-highlighting.zsh
