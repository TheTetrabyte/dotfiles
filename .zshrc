export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

plugins=(
    git
    sudo
)

source $ZSH/oh-my-zsh.sh

export EDITOR=/usr/bin/vim
export TERM=xterm-256color

export GOPATH=/Users/dustinrouillard/.gopath
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

#upload() {
#    FILE_URL=$(curl -F "file=@$1" $UPLOADER_URL -H "token: $UPLOADER_TOKEN" -s)
#    osascript -e 'display notification "'"$FILE_URL"'" with title "Upload Successful"'
#    echo $FILE_URL | pbcopy
#    echo $FILE_URL
#}

upload() {
	FILE="${PWD}/${@}"
	~/Projects/Personal/mac-screenshot/upload-gcs.sh ${FILE}
}

screenshot() {	
	~/Projects/Personal/mac-screenshot/screenshot-gcs.sh
}

shorten() {
	if [ "$1" = "" ]; then; return 1; fi

	JWT_EXPIRY="$(($(date +%s)+30))"

	HEADER="$(echo -n '{"alg":"HS256","typ":"JWT"}' | openssl base64 -e -A | sed s/\+/-/g | sed -E s/=+$// | sed 's/\//_/g')"
	PAYLOAD="$(echo -n '{"iss":"dustin.click","exp":'$JWT_EXPIRY'}' | openssl base64 -e -A | sed s/\+/-/g | sed -E s/=+$// | sed 's/\//_/g')"
	SIGNATURE="$(echo -n ${HEADER}.${PAYLOAD} | openssl dgst -sha256 -hmac $PERSONAL_SHORTENER_JWT_SECRET -binary | openssl base64 -e -A | sed s/\+/-/g | sed -E s/=+$// | sed 's/\//_/g')"

	TOKEN="$(echo ${HEADER}.${PAYLOAD}.${SIGNATURE})"

	if [ "$2" = "" ]; then;
		URL_CODE=$(http POST https://dustin.link/create Authorization:$TOKEN target=$1 | jq -r .code)
	else
		URL_CODE=$(http POST https://dustin.link/create Authorization:$TOKEN target=$1 code=$2 | jq -r .code)
	fi

	echo "Shortened URL $1 -> https://dustin.link/$URL_CODE"
	echo "https://dustin.link/$URL_CODE" | pbcopy
	return 0
}

export GPG_TTY=$(tty) 

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dustinrouillard/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/dustinrouillard/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/dustinrouillard/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/dustinrouillard/google-cloud-sdk/completion.zsh.inc'; fi

export PATH="/usr/local/Cellar/openvpn/2.4.7/sbin:/usr/local/bin:$PATH"

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/opt/node@10/bin:$PATH"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault

export OH_MY_NEOVIM=/Users/dustinrouillard/.oh-my-neovim
export OH_MY_NEOVIM_EXTENSIONS="default git go gpg javascript json neomake nodejs react tmux typescript vim web"
source /Users/dustinrouillard/.oh-my-neovim/tools/functions.sh
source ~/.notify_cli
source ~/.hiven_cli

PATH="/Users/dustinrouillard/.gem/ruby/2.6.0/bin:$PATH"
PATH="/Users/dustinrouillard/.node_modules_global/bin:$PATH"
