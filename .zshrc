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
alias ask="gh copilot suggest"
alias gitui="gitui -t frappe.ron"


# SHORTCUT COMMANDS
alias ports="sudo lsof -i -P -n | grep LISTEN"
alias winr="tmux rename-window"
alias wins="tmux swap-window -t"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias :q="exit"
alias keepass-push="rclone sync local_drive/keepass.kdbx driver:linux"
alias keepass-pull="rclone sync driver:linux/keepass.kdbx local_drive"
alias pip='pip3'
alias python='python3'
alias enc='~/Tools/encryptor.sh'
alias kali-forward='socat TCP-LISTEN:4444,fork TCP:10.211.55.4:4444'
alias exegol="python3 /Users/adelapazborrero/Tools/Exegol/exegol.py"

# APPLICATIONS
alias v="nvim"
alias t="tmux"
alias mobsf="docker run -it --rm -p 8000:8000 opensecurity/mobile-security-framework-mobsf:latest"
alias store="~/Tools/pling-store-5.0.2-1-x86_64.AppImage" # Linux only
alias tree="lsd --tree"
alias act="~/Tools/act/bin/act"
alias incursore="~/Tools/incursore.sh"
alias pwsh="/opt/homebrew/opt/powershell-lts/bin/pwsh-lts"
alias ghidra="~/Tools/ghidra_11.1.1_PUBLIC/ghidraRun"
alias rustscan='docker run -it --rm --name rustscan rustscan/rustscan:2.1.1'
alias jwt-tool="python3 ~/Tools/jwt_tool/jwt_tool.py"
alias phone="echo 4386"
alias slackjack="/Users/adelapazborrero/Tools/slack_jack/slack_jack"

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

# alias cat="bat"

alias config="nvim ~/.zshrc"
alias sconfig="source ~/.zshrc"
alias x="exit"
alias rice="curl -L rum.sh/ricebowl"
alias notes="nvim ~/Documents/nvim_notes"
alias pentest="nvim ~/Documents/pentest.md"
alias kali="orb"
alias kali-desktop="xfreerdp /u:typ0 /p:sombi /v:localhost /cert-ignore /auto-reconnect-max-retries:0 /smart-sizing +clipboard /home-drive"
alias gitleaks="~/Tools/gitleaks/gitleaks"

# H4cking_T0ols
alias waybackurls="/Users/adelapazborrero/Tools/waybackurls/waybackurls"


# CUSTOM FUNCTIONS
playyt() {
    for cmd in yt-dlp fzf mpv; do
      if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "❌ Required tool '$cmd' is not installed. Please install it first."
        exit 1
      fi
    done

    if [[ $# -eq 0 ]]; then
      echo "❗️ Usage: $0 <search terms>"
      echo "    Example: $0 lo-fi hip hop"
      exit 1
    fi

    SEARCH="$*"
    echo "🔎 Searching for: $SEARCH"

    RESULTS=$(yt-dlp "ytsearch10:$SEARCH" --flat-playlist --print "%(title)s | %(id)s")

    if [[ -z "$RESULTS" ]]; then
      echo "❌ No results found."
      exit 1
    fi

    CHOICE=$(echo "$RESULTS" | fzf --prompt="🎵 Choose a video: " --height=20 --border)

    if [[ -z "$CHOICE" ]]; then
      echo "❌ No selection made."
      exit 1
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

function fmn() {
    ~/Tools/find-my-namespace/fmn $1 $2
}

function wins() {
    tmux swap-window -t $1 && tmux select-window -t $1
}

# function serve() {
#     clear

#     RED='\033[0;31m' # Red color
#     NC='\033[0m' # No Color

#     # Show IPs
#     echo -e "${RED}[+] Current IP${NC}"
#     ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}'

#     echo -e "\n${RED}[+] Current files${NC}"
#     # List current folder
#     if command -v lsd > /dev/null 2>&1; then
#         lsd --tree .
#     else
#         ls -R
#     fi

#     echo -e "\n${RED}[+] Starting server...${NC}"
#     local current_folder="$(pwd)"
#     local certificate="/Users/adelapazborrero/go/src/github.com/adelapazborrero/https_server/server.crt"
#     local key="/Users/adelapazborrero/go/src/github.com/adelapazborrero/https_server/server.key"
#     /Users/adelapazborrero/go/src/github.com/adelapazborrero/https_server/https_server --dir="$current_folder" --cert="$certificate" --key="$key"
# }

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
    
    local port="${1:-443}"  # Default to 443 if no port is provided
    local current_folder="$(pwd)"
    local certificate="/Users/adelapazborrero/go/src/github.com/adelapazborrero/https_server/server.crt"
    local key="/Users/adelapazborrero/go/src/github.com/adelapazborrero/https_server/server.key"

    /Users/adelapazborrero/go/src/github.com/adelapazborrero/https_server/https_server --dir="$current_folder" --addr=":$port" --cert="$certificate" --key="$key"
}

# function serve() {
#     clear

#     RED='\033[0;31m' # Red color
#     NC='\033[0m' # No Color

#     # Show IPs
#     echo -e "${RED}[+] Current IP${NC}"
#     ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}'

#     echo -e "\n${RED}[+] Current files${NC}"
#     # List current folder
#     if command -v lsd > /dev/null 2>&1; then
#         lsd --tree .
#     else
#         ls -R
#     fi

#     echo -e "\n${RED}[+] Starting server...${NC}"
#     # Start server
#     sudo python3 -m http.server 80
# }

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

jwt-decode() {
    jq -R 'split(".") | select(length > 0) | .[0],.[1] | @base64d | fromjson' <<< $1
}

jwt-edit() {
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    BLUE='\033[0;34m'
    NC='\033[0m'

    if [ -z "$1" ]; then
        echo "Usage: jwt-edit <jwt_token>"
        return 1
    fi

    local jwt="$1"
    local header payload signature
    IFS='.' read -r header payload signature <<< "$jwt"

    b64url_to_b64() {
        local input="$1"
        local len=$(( ${#input} % 4 ))
        case $len in
            2) input="${input}==";;
            3) input="${input}=";;
        esac
        echo "${input//-/+}" | sed 's/_/\//g'
    }

    local decoded_header decoded_payload
    decoded_header=$(echo "$(b64url_to_b64 "$header")" | base64 -d 2>/dev/null)
    decoded_payload=$(echo "$(b64url_to_b64 "$payload")" | base64 -d 2>/dev/null)

    if [[ -z "$decoded_header" || -z "$decoded_payload" ]]; then
        echo "${RED}[-] Failed to decode JWT. Invalid base64 or JSON.${NC}"
        return 1
    fi

    local tmpfile
    tmpfile=$(mktemp /tmp/jwt-edit.XXXXXX.json)
    jq -n --argjson header "$decoded_header" --argjson payload "$decoded_payload" \
        '{header: $header, payload: $payload}' > "$tmpfile"

    nvim "$tmpfile"

    local new_header new_payload
    new_header=$(jq -c .header "$tmpfile")
    new_payload=$(jq -c .payload "$tmpfile")

    if [[ -z "$new_header" || -z "$new_payload" ]]; then
        echo "${RED}[-] Invalid JSON after editing.${NC}"
        rm -f "$tmpfile"
        return 1
    fi

    b64url_encode() {
        echo -n "$1" | base64 | tr '+/' '-_' | tr -d '='
    }

    local new_header_b64 new_payload_b64
    new_header_b64=$(b64url_encode "$new_header")
    new_payload_b64=$(b64url_encode "$new_payload")

    clear
    local new_jwt="${new_header_b64}.${new_payload_b64}.${signature}"

    echo -e "${GREEN}[+] Manipulated JWT:${NC}"

    if command -v pbcopy >/dev/null; then
        echo -n "$new_jwt" | pbcopy
        echo "${GREEN}[+] JWT copied to clipboard (pbcopy)${NC}"
    elif command -v xclip >/dev/null; then
        echo -n "$new_jwt" | xclip -selection clipboard
        echo "${GREEN}[+] JWT copied to clipboard (xclip)${NC}"
    elif command -v xsel >/dev/null; then
        echo -n "$new_jwt" | xsel --clipboard --input
        echo "${GREEN}[+] JWT copied to clipboard (xsel)${NC}"
    else
        echo "${RED}[-] Clipboard copy failed: no clipboard utility found (pbcopy/xclip/xsel)${NC}"
    fi
    echo "\n${BLUE}Output:${NC}"
    echo "${new_jwt}"

    rm -f "$tmpfile"
}


gitlab-token() {
    echo "tokens"
    url="https://gitlab.bol.io/api/v4/personal_access_tokens/self?private_token=$1"
    echo "Trying with $url"
    echo ""
    echo "[PRODUCTION]"
    echo ""
    curl  "https://gitlab.bol.io/api/v4/personal_access_tokens/self?private_token=$1" --silent | json_pp
    echo ""
    echo "[STAGING]"
    echo ""
    curl  "https://gitlab.stg.bol.io/api/v4/personal_access_tokens/self?private_token=$1" --silent | json_pp
}

gitlab-token-check(){
    python3 ~/Tools/gitlab-exploits/gitlab_token_checker.py $1
}

gitlab-pipeline-rce(){
    python3 ~/Tools/gitlab-exploits/gitlab_pipeline_pusher.py $1 $2 $3
}

function collaborator() {
    gcloud compute ssh --zone "europe-west4-a" "maatthijs-vm" --tunnel-through-iap --project "leaseweb-secops" -- -NL 5000:localhost:5000
}

function serve-ftp() {
    RED='\033[0;32m'
    NC='\033[0m' # No Color
    #show ips
    echo "${RED}[+] Current IP${NC}"
    ip r|grep " link "|cut -d " " -f 3,9

    python3 -m pyftpdlib -p 21 --write
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

function import-jira(){
    python3 /Users/adelapazborrero/Tools/txt-to-jira/main.py -f $1 -p SEC --prefix '[Pentest]'
}

# export FZF_DEFAULT_COMMAND="nvim"
export FZF_DEFAULT_OPTS='--border --preview "bat {}" '
export PATH="$PATH:$HOME/.config/composer/vendor/bin"
export BAT_THEME="Catppuccin-frappe"

# GOLANG
# export GOPROXY="https://artifactory.tools.bol.com/artifactory/go-bol/"
# export GOSUMDB="sum.golang.org https://artifactory.tools.bol.com/artifactory/sum-golang-org/"
# export GOPRIVATE="gitlab.bol.io"
export GOPATH="$HOME/go"
PATH="$GOPATH/bin:$PATH"

# export NVM_DIR="$HOME/.nvm"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
alias nvm="unalias nvm; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; nvm $@"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# RUBY
export PATH="/usr/local/opt/ruby/bin:$PATH"
if [ -d "/usr/local/opt/ruby/bin" ]; then
  export PATH=/usr/local/opt/ruby/bin:$PATH
  export PATH=`gem environment gemdir`/bin:$PATH
fi

# GOOGLE SDK
source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"

#BOL TOOLS
export PATH="/Users/adelapazborrero/find-my-namespace:$PATH"
export PATH="/usr/local/sbin:$PATH"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/adelapazborrero/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# bun completions
[ -s "/Users/adelapazborrero/.bun/_bun" ] && source "/Users/adelapazborrero/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


source ~/.config/z/zsh-z.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export PATH="$PATH:/Users/adelapazborrero/Library/Python/3.9/bin"
export PATH="$PATH:/Users/adelapazborrero/Library/Android/sdk/build-tools/35.0.0"
export PATH="$PATH:/Users/adelapazborrero/Tools/graudit"

eval "$(starship init zsh)"

. "$HOME/.cargo/env"
. "/Users/adelapazborrero/.deno/env"

# Added by Windsurf
export PATH="/Users/adelapazborrero/.codeium/windsurf/bin:$PATH"
