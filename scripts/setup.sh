#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Homebrew がシェルの PATH に入っていない環境（Apple Silicon の初回セットアップなど）
# でも brew を利用できるようにする。
if command -v brew >/dev/null 2>&1; then
  BREW="$(command -v brew)"
elif [ -x /opt/homebrew/bin/brew ]; then
  BREW=/opt/homebrew/bin/brew
elif [ -x /usr/local/bin/brew ]; then
  BREW=/usr/local/bin/brew
else
  echo "Homebrew が見つかりません。先に Homebrew をインストールしてください。" >&2
  exit 1
fi

eval "$("$BREW" shellenv)"

for package in go gh mise neovim ripgrep fd; do
  command_name="$package"
  if [ "$package" = neovim ]; then
    command_name=nvim
  elif [ "$package" = ripgrep ]; then
    command_name=rg
  fi

  if ! command -v "$command_name" >/dev/null 2>&1; then
    echo "$package をインストールします..."
    "$BREW" install "$package"
  fi
done

# リポジトリで宣言した mise 管理ツールをすべてインストールする。
mise -C "$SCRIPT_DIR/.." install

bash "$SCRIPT_DIR/setup-git.sh"
bash "$SCRIPT_DIR/setup-dotfiles-symlink.sh"
bash "$SCRIPT_DIR/setup-zsh.sh"
bash "$SCRIPT_DIR/setup-screenshot.sh"
