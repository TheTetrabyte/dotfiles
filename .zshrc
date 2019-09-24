export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

plugins=(
    git
    sudo
)

source $ZSH/oh-my-zsh.sh

export EDITOR=/usr/bin/vim
export TERM=xterm-256color

export GOPATH=/Users/byte/.gopath
export GOHOME=$GOPATH/bin
export GO111MODULE=on
export PATH="$GOHOME:$PATH"

alias projects="cd ~/Projects"

source ~/.secrets

UPLOAD_URL="https://i.notifycdn.me"

upload() {
    FILE_URL=$(curl -F "file=@$1" $UPLOADER_URL -H "token: $UPLOADER_TOKEN" -s)
    echo $FILE_URL
}

export GPG_TTY=`tty`

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/byte/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/byte/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/byte/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/byte/google-cloud-sdk/completion.zsh.inc'; fi

export PATH="/usr/local/Cellar/openvpn/2.4.7/sbin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
