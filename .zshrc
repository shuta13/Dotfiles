# homebrew
eval $(/opt/homebrew/bin/brew shellenv)

# zsh
## plugins（全てgit cloneで.zshフォルダにコピーする。）
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/git-prompt.sh

## ブランチ名表示 
## https://qiita.com/mikan3rd/items/d41a8ca26523f950ea9d
fpath=(~/.zsh $fpath)
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.zsh

## zshの補完有効化
## https://gihyo.jp/dev/serial/01/zsh-book/0005
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'

## zshの表示変更
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

## zshの色の指定
autoload -Uz colors && colors
# setopt PROMPT_SUBST ; PS1='%F{green}%n@%m%f: %F{cyan}%~%f %F{red}$(__git_ps1 "(%s)")%f
setopt PROMPT_SUBST ; PS1='%F{cyan}%~%f %F{red}$(__git_ps1 "(%s)")%f
\$ '

# rbenv
# eval "$(rbenv init - zsh)"

# pyenv
# eval "$(pyenv init -)"
# export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"

# volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# istioctl
export PATH=$HOME/.istioctl/bin:$PATH

# go
export PATH=$HOME/goroot/bin:$PATH
export PATH=$HOME/go/bin:$PATH

# cycloud
export PATH=$HOME/.config/cycloud/bin:$PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/s13189/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/s13189/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/s13189/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/s13189/google-cloud-sdk/completion.zsh.inc'; fi
