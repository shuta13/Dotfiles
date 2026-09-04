#!/bin/bash

set -euo pipefail

mkdir -p "$HOME/Pictures/ScreenShots"

defaults write com.apple.screencapture location "$HOME/Pictures/ScreenShots/"
