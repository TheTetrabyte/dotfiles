export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

plugins=(
    git
    sudo
)

source $ZSH/oh-my-zsh.sh

export EDITOR=/usr/bin/vim
export TERM=xterm-256color
export GO111MODULE=on

alias projects="cd ~/Projects"

source ~/.secrets
source ~/.profile

#alias tweetdeck="nohup google-chrome-stable --app=https://tweetdeck.twitter.com/ <&- & "

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
