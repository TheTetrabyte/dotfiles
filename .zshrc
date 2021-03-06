export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="avit"

plugins=(
    git
    sudo
)

source $ZSH/oh-my-zsh.sh

export EDITOR=/usr/bin/vim
export TERM=xterm-256color

export GOPATH=/Users/dustin/.gopath
export GOHOME=$GOPATH/bin
export GO111MODULE=on
export PATH="$GOHOME:/usr/local/Cellar/node/13.1.0/bin:/etc/deel/bin:$PATH"

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PROJECTS="${HOME}/Projects";

alias projects="cd $PROJECTS"
alias gopath="cd $GOPATH/src"

alias kattach="/usr/local/bin/kubectl attach -i -t"
alias kget="/usr/local/bin/kubectl get"
alias kdelete="/usr/local/bin/kubectl delete"
#alias k="/usr/local/bin/kubectl"

source ~/.secrets
source ~/.jwt

preexec () {
  # Prep for tracking weekly commands run
  TOKEN=$(jwt dustin.sh/api $PERSONAL_API_INTERNAL_SECRET)
  curl -X "POST" "${PERSONAL_API_HOST}/stats/track/commands" -H "Authorization: $TOKEN" -s &>/dev/null
  if [[ $1 = "docker build"* ]]; then
    curl -X "POST" "${PERSONAL_API_HOST}/stats/track/docker" -H "Authorization: $TOKEN" -s &>/dev/null
  fi
}

upload() {
	FILE="${PWD}/${1}"
	~/Projects/Personal/mac-screenshot/upload-api.sh ${FILE} $2
}

screenshot() {	
	~/Projects/Personal/mac-screenshot/screenshot-api.sh
}

shorten() {
	if [ "$1" = "" ]; then; return 1; fi

	TOKEN=$(jwt dustin.click $PERSONAL_SHORTENER_JWT_SECRET)

	if [ "$2" = "" ]; then;
		URL_CODE=$(http POST https://dstn.to/create Authorization:$TOKEN target=$1 | jq -r .code)
	else
		URL_CODE=$(http POST https://dstn.to/create Authorization:$TOKEN target=$1 code=$2 | jq -r .code)
	fi

	echo "Shortened URL $1 -> https://dstn.to/$URL_CODE"
	echo "https://dstn.to/$URL_CODE" | pbcopy
	return 0
}

export GPG_TTY=$(tty) 

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dustin/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/dustin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/dustin/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/dustin/google-cloud-sdk/completion.zsh.inc'; fi

export ANDROID_SDK_ROOT="${HOME}/.android"
export PATH="/usr/local/Cellar/openvpn/2.4.7/sbin:/usr/local/bin:${HOME}/.android/tools/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

kexec() {
    COMMAND=$(printf '%s' "${@//$1/}")
    /usr/local/bin/kubectl exec -it $1 $COMMAND
}

gcs() {
    COMMAND=$1
    BUCKET=$2

    if [ $COMMAND = "size" ]; then
        BUCKET_SIZE=$(gsutil du -sh $BUCKET)
        echo "Bucket ${BUCKET:5} has $(echo $BUCKET_SIZE | cut -d" " -f1) $(echo $BUCKET_SIZE | cut -d" " -f2) used"
    else;
        gsutil $@
    fi
}

pbedit() {
    local _t=$(mktemp)
    chmod 600 "$_t"

    pbpaste > "$_t"
    ${EDITOR:-vi} "$_t"
    pbcopy < "$_t"

    rm -f "$_t"
}

personal() {
	echo "Setting gcloud to match personal project"
	gcloud config set account me@dustin.sh &>/dev/null
	gcloud config set project dustin-rouillard &>/dev/null
	gcloud container clusters get-credentials personal --zone us-east1-d &>/dev/null
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/opt/node@10/bin:$PATH"
export PATH="${PATH}:${HOME}/.krew/bin"

source ~/.system-theme-sync-iterm2  

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault

export OH_MY_NEOVIM=/Users/dustin/.oh-my-neovim
export OH_MY_NEOVIM_EXTENSIONS="default git go gpg javascript json neomake nodejs react tmux typescript vim web"
source /Users/dustin/.oh-my-neovim/tools/functions.sh

source ~/.notify_cli
source ~/.hiven_cli

export DENO_INSTALL="/Users/dustin/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

export PATH="/Users/dustin/.gem/ruby/2.6.0/bin:$PATH"
export PATH="/Users/dustin/.node_modules_global/bin:$PATH"
