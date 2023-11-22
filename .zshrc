export LANG=en_US.UTF-8

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


# SHORTCUT COMMANDS
alias ports="sudo lsof -i -P -n | grep LISTEN"
alias winr="tmux rename-window"
alias wins="tmux swap-window -t"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias :q="exit"

# APPLICATIONS
alias v="nvim"
alias t="tmux"
alias store="~/Tools/pling-store-5.0.2-1-x86_64.AppImage" # Linux only
alias tree="lsd --tree"
alias code="code . && exit"
alias act="~/Tools/act/bin/act"

# DEVOPS
alias dc="docker-compose"
alias k="kubectl"
alias kg="kubectl get"
alias kc="kubectx"

# OTHER
# If broken icons [curl https://raw.githubusercontent.com/UTFeight/logo-ls-modernized/master/INSTALL | bash]
alias l="logo-ls -l"
alias ll="logo-ls -la"

alias config="nvim ~/.zshrc"
alias sconfig="source ~/.zshrc"
alias x="exit"
alias open="xdg-open" # Linux only
alias restart-audio="systemctl restart --user pulseaudio" # Linux only
alias clear-cache="paccache -rk2 && paccache -ruk1 && paccache -rk2 -c ~/.cache/yay/*/ && paccache -ruk0 ~/.cache/yay/*/" # Arch only
alias rice="curl -L rum.sh/ricebowl"
alias notes="nvim ~/Documents/notes.norg"

# CUSTOM FUNCTIONS
function gri(){
    git rebase -i HEAD~$1
}

function squash(){
    it reset $(git merge-base master $(git branch --show-current))
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

function fmn-clear() {
    rm ~/.config/fmn.json
}

function fix-keys() {
    hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000035,"HIDKeyboardModifierMappingDst":0x700000064},{"HIDKeyboardModifierMappingSrc":0x700000064,"HIDKeyboardModifierMappingDst":0x700000035}]}'
}

# export FZF_DEFAULT_COMMAND="nvim"
export FZF_DEFAULT_OPTS='--border --preview "bat {}" '
export PATH="$PATH:$HOME/.config/composer/vendor/bin"
BAT_THEME="Catppuccin-frappe"

# GOLANG
export GOPROXY="https://artifactory.tools.bol.com/artifactory/go-bol/"
export GOSUMDB="sum.golang.org https://artifactory.tools.bol.com/artifactory/sum-golang-org/"
export GOPRIVATE="gitlab.bol.io"
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
#export PATH="/Users/adelapazborrero/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# bun completions
[ -s "/Users/adelapazborrero/.bun/_bun" ] && source "/Users/adelapazborrero/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

source ~/.zsh/catppuccin_frappe-zsh-syntax-highlighting.zsh
source ~/.config/z/zsh-z.plugin.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(starship init zsh)"
