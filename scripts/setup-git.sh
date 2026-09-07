#!/bin/bash

set -euo pipefail

GITIGNORE_DIR="$HOME/gitignore"
GITIGNORE_REPOSITORY="https://github.com/github/gitignore.git"
GLOBAL_GITIGNORE="$GITIGNORE_DIR/Global/macOS.gitignore"

if [ ! -d "$GITIGNORE_DIR/.git" ]; then
  if [ -e "$GITIGNORE_DIR" ]; then
    echo "$GITIGNORE_DIR はGitリポジトリではありません。既存のディレクトリを確認してください。" >&2
    exit 1
  fi

  echo "グローバルGit ignoreを取得します..."
  git clone "$GITIGNORE_REPOSITORY" "$GITIGNORE_DIR"
fi

if [ ! -f "$GLOBAL_GITIGNORE" ]; then
  echo "$GLOBAL_GITIGNORE が見つかりません。gitignoreリポジトリの構成を確認してください。" >&2
  exit 1
fi

git config --global core.excludesfile "$GLOBAL_GITIGNORE"
