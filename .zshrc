export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

plugins=(
    git
    sudo
)

source $ZSH/oh-my-zsh.sh

export EDITOR=/usr/bin/vim
export TERM=xterm-256color

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
