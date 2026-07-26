export LAN=en_US.UTF-8

# GIT ALIASES
alias s="git status"
alias a="git add ."
alias c="git commit"
alias p="git push"
alias gl="git log"
alias gc="git checkout"
alias glo="git log --oneline"
alias gd="git diff ."
alias gds="git diff --staged ."
alias gitui="gitui -t frappe.ron"


# SHORTCUT COMMANDS
alias ports="sudo lsof -i -P -n | grep LISTEN"
alias winr="tmux rename-window"
alias wins="tmux swap-window -t"
alias :q="exit"
alias pip='pip3'
alias python='python3'

# APPLICATIONS
alias v="nvim"
alias t="tmux"
alias tree="lsd --tree"

# DEVOPS
alias dc="docker-compose"
alias k="kubectl"
alias kg="kubectl get"
alias kc="kubectx"

# OTHER
# If broken icons [curl https://raw.githubusercontent.com/UTFeight/logo-ls-modernized/master/INSTALL | bash]
# alias l="logo-ls -l --disable-color"
# alias dir="logo-ls -l --disable-color"
# alias ll="logo-ls -la --disable-color"

alias l="logo-ls -l"
alias dir="logo-ls -l"
alias ll="logo-ls -la"

alias config="nvim ~/.zshrc"
alias sconfig="source ~/.zshrc"
alias x="exit"
alias rice="curl -L rum.sh/ricebowl"
alias notes="nvim ~/Documents/nvim_notes"
alias pentest="nvim ~/Documents/pentest.md"


# CUSTOM FUNCTIONS
playyt() {
    for cmd in yt-dlp fzf mpv; do
      if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "❌ Required tool '$cmd' is not installed. Please install it first."
        return
      fi
    done

    if [[ $# -eq 0 ]]; then
      echo "❗️ Usage: $0 <search terms>"
      echo "    Example: $0 lo-fi hip hop"
      return
    fi

    SEARCH="$*"
    echo "🔎 Searching for: $SEARCH"

    RESULTS=$(yt-dlp "ytsearch10:$SEARCH" --flat-playlist --print "%(title)s | %(id)s")

    if [[ -z "$RESULTS" ]]; then
      echo "❌ No results found."
      return
    fi

    CHOICE=$(echo "$RESULTS" | fzf --prompt="🎵 Choose a video: " --height=20 --border)

    if [[ -z "$CHOICE" ]]; then
      echo "❌ No selection made."
      return
    fi

    VIDEO_ID=$(echo "$CHOICE" | awk -F ' | ' '{print $NF}')
    URL="https://www.youtube.com/watch?v=$VIDEO_ID"

    echo "▶️ Now playing: $CHOICE"
    mpv --no-video --ytdl-format=bestaudio "$URL"
}

function gri() {
    if [ -z "$1" ]; then
        echo "Usage: gri <number_of_commits_to_reset>"
        return 1
    fi

    git reset --soft HEAD~$1
    git commit

    # Flush input buffer just in case, then read
    echo
    read -r -p "Do you want to push with --force-with-lease? [Y/n] " confirm
    case "$confirm" in
        [Yy]|"")
            git push --force-with-lease
            ;;
        [Nn])
            echo "Push aborted."
            ;;
        *)
            echo "Invalid input. Push aborted."
            ;;
    esac
}

function help(){
  curl cheat.sh/$1
}

function kill-port(){
  sudo kill -9 $(sudo lsof -t -i:$1)
}


function serve() {
    clear

    RED='\033[0;31m' # Red color
    NC='\033[0m' # No Color

    # Show IPs
    echo -e "${RED}[+] Current IP${NC}"
    ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}'

    echo -e "\n${RED}[+] Current files${NC}"
    # List current folder
    if command -v lsd > /dev/null 2>&1; then
        lsd --tree .
    else
        ls -R
    fi

    echo -e "\n${RED}[+] Starting server...${NC}"
    # Start server
    sudo python3 -m http.server 80
}

function scan() {
    GREEN='\033[0;32m'
    PURPLE='\033[0;35m'
    NC='\033[0m'
    ttl="$(ping -c 1 $1 | grep ttl | awk '{print $6}' |  sed s/ttl=//)"


    if [[ -z "$ttl" ]]; then
        echo -e "[?] Host is not responding, trying pinging"
        return
    fi

    if [ $ttl -le 64 ]; then
        echo -e "\n${GREEN}Target OS: ${PURPLE}LINUX${NC}"
    else
        echo -e "\n${GREEN}Target OS: ${PURPLE}WINDOWS${NC}"
    fi

    echo -e "\n${GREEN}[+] Starting scan on target\n${NC}"


    sudo nmap -p- --open -sS --min-rate 5000 -vvv -n -Pn $1 -oG .tempPorts

    ports="$(cat .tempPorts | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
    echo -e "\n${GREEN}[+] Running scan for open ports: ${PURPLE}$ports${NC}\n" >> .extractPorts.tmp

    cat .extractPorts.tmp

    sudo nmap -sCV -p$ports $1 -oN target-scan
    rm -f .tempPorts
    rm -f .extractPorts.tmp
}

function forward-http() {
    local subdomain=""
    local parser_flag="parser"

    while getopts ":s:" opt; do
        case $opt in
            s)
                subdomain="$OPTARG"
                ;;
            \?)
                echo "Invalid option: -$OPTARG"
                echo "Usage: forward-http [-s <subdomain>] <port>"
                return 1
                ;;
        esac
    done

    shift $((OPTIND-1))

    if [ "$#" -ne 1 ]; then
        echo "Usage: forward-http [-s <subdomain>] <port>"
        return 1
    fi

    if [ -n "$subdomain" ]; then
        parser_flag="$subdomain"
    fi

    ssh -R "${parser_flag}.serveo.net:80:localhost:$1" serveo.net
}

function jwt-decode() {
    jq -R 'split(".") | select(length > 0) | .[0],.[1] | @base64d | fromjson' <<< $1
}

function serve-ftp() {
    RED='\033[0;32m'
    NC='\033[0m' # No Color
    #show ips
    echo "${RED}[+] Current IP${NC}"
    ip r|grep " link "|cut -d " " -f 3,9

    python3 -m pyftpdlib -p 21 --write
}

# GOLANG
# export GOPROXY="https://artifactory.tools.bol.com/artifactory/go-bol/"
# export GOSUMDB="sum.golang.org https://artifactory.tools.bol.com/artifactory/sum-golang-org/"
# export GOPRIVATE="gitlab.bol.io"
export GOPATH="$HOME/go"
PATH="$GOPATH/bin:$PATH"


# GOOGLE SDK
# source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
# source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"

eval "$(starship init zsh)"

