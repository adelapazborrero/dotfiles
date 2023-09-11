# PROMPT
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  z
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

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

# SHORTCUT COMMANDS
alias ports="sudo lsof -i -P -n | grep LISTEN"
alias docker-down="sudo chmod 666 /var/run/docker.sock"
alias win="tmux rename-window"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias :q="exit"

# APPLICATIONS
alias v="nvim"
alias t="tmux"
alias store="~/Tools/pling-store-5.0.2-1-x86_64.AppImage"
alias tree="lsd --tree"
alias dc="docker-compose"
alias dce="docker-compose exec"
alias code="code . && exit"
alias mk="microk8s kubectl"
alias monkey="toipe"
alias dclean="docker rmi $(docker images -a|grep "<none>"|awk '$1=="<none>" {print $3}')"
alias stoplight="~/Tools/stoplight-studio-linux-x86_64.AppImage"
alias act="~/Tools/act/bin/act"

# OTHER
# If broken icons [curl https://raw.githubusercontent.com/UTFeight/logo-ls-modernized/master/INSTALL | bash]
alias l="logo-ls -l"
alias ll="logo-ls -la"

alias config="nvim ~/.zshrc"
alias sconfig="source ~/.zshrc"
alias x="exit"
alias open="xdg-open"
alias restart-audio="systemctl restart --user pulseaudio"
alias clear-cache="paccache -rk2 && paccache -ruk1 && paccache -rk2 -c ~/.cache/yay/*/ && paccache -ruk0 ~/.cache/yay/*/"
alias anime="~/Tools/ani-cli/bin/ani-cli"
alias rice="curl -L rum.sh/ricebowl"
alias notes="nvim ~/Documents/notes.md"

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

function fmn-clear() {
    rm ~/.config/fmn.json
}

configure_prompt() {
    prompt_symbol=㉿
    # Skull emoji for root terminal
    [ "$EUID" -eq 0 ] && prompt_symbol=💀
    PROMPT=$'%F{%(#.blue.green)}┌──${debian_chroot:+($debian_chroot)─}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))─}(%B%F{%(#.red.blue)}%n'$prompt_symbol$'%m%b%F{%(#.blue.green)})-[%B%F{reset}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.blue.green)}]\n└─%B%(#.%F{red}#.%F{blue}$)%b%F{reset} '
    # Right-side prompt with exit codes and background processes
    RPROMPT=$'%(?.. %? %F{red}%B⨯%b%F{reset})%(1j. %j %F{yellow}%B⚙%b%F{reset}.)'
    unset prompt_symbol
}


function fix-keys() {
    hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000035,"HIDKeyboardModifierMappingDst":0x700000064},{"HIDKeyboardModifierMappingSrc":0x700000064,"HIDKeyboardModifierMappingDst":0x700000035}]}'
}

function local-db() {
    pgcli postgres://cdn:pass4rd@localhost:5432/cdn
}

# export FZF_DEFAULT_COMMAND="nvim"
export FZF_DEFAULT_OPTS='--border --preview "bat {}" '
export PATH="$PATH:$HOME/.config/composer/vendor/bin"

export OPENAI_API_KEY=""

# GOLANG
export GOPATH="$HOME/go"
PATH="$GOPATH/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#source /usr/share/nvm/init-nvm.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Disable warning about zsh prompt
# typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
# neofetch --ascii --source ~/Projects/ascii/cat.txt --ascii_colors 3 5 6 2

# RUBY
export PATH="/usr/local/opt/ruby/bin:$PATH"
if [ -d "/usr/local/opt/ruby/bin" ]; then
  export PATH=/usr/local/opt/ruby/bin:$PATH
  export PATH=`gem environment gemdir`/bin:$PATH
fi

# GOOGLE SDK
source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"

source ~/.zsh/catppuccin_frappe-zsh-syntax-highlighting.zsh
