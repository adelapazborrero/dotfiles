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
alias open='xdg-open'

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

# logo-ls spaces its icons with U+2800 (braille blank) rather than a space.
# kitty only grows a wide icon glyph into the *empty* cells after it, so that
# braille char keeps every icon squeezed into one cell (looks like the "Mono"
# Nerd Font). logo-ls-icons swaps it for a real space -> full-size icons.
alias logo-ls="logo-ls-icons"
alias l="logo-ls-icons -l"
alias dir="logo-ls-icons -l"
alias ll="logo-ls-icons -la"

# alias cat="bat"

alias config="nvim ~/.zshrc"
alias sconfig="source ~/.zshrc"
alias x="exit"
alias rice="curl -L rum.sh/ricebowl"
alias gitleaks="~/Tools/gitleaks/gitleaks"

# H4cking_T0ols
alias waybackurls="/Users/adelapazborrero/Tools/waybackurls/waybackurls"


# CUSTOM FUNCTIONS
function server() {
  ssh abel@192.168.2.12
}

function help(){
  curl cheat.sh/$1
}

function kill-port(){
  sudo kill -9 $(sudo lsof -t -i:$1)
}


function wins() {
    tmux swap-window -t $1 && tmux select-window -t $1
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
    
    local port="${1:-443}"  # Default to 443 if no port is provided
    local current_folder="$(pwd)"
    local certificate="/Users/adelapazborrero/go/src/github.com/adelapazborrero/https_server/server.crt"
    local key="/Users/adelapazborrero/go/src/github.com/adelapazborrero/https_server/server.key"

    /Users/adelapazborrero/go/src/github.com/adelapazborrero/https_server/https_server --dir="$current_folder" --addr=":$port" --cert="$certificate" --key="$key"
}

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



# LOCAL BIN
export PATH="$HOME/.local/bin:$PATH"

# GOLANG
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"


eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
