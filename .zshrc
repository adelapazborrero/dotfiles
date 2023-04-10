# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  z
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

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
alias sqlmap="/usr/bin/python3 /home/abeldlp/Projects/personal/sqlmap/sqlmap.py"
alias stoplight="~/Tools/stoplight-studio-linux-x86_64.AppImage"
alias act="~/Tools/act/bin/act"

# OTHER
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
function kubectx(){
    if [ $# -eq 0 ]
      then
        kubectl config get-contexts
        return
    fi

    kubectl config use-context $1

    # if [$1]; then
    #     kubectl config use-context $1
    # else
    #     kubectl config get-contexts
    # fi
}

function gri(){
    git rebase -i HEAD~$1
}

function squash(){
    it reset $(git merge-base master $(git branch --show-current))
}

function clean(){
  PACMAN_CACHE=$(pacman -Qtdq)
  YAY_CACHE=$(yay -Qtdq)

  if [[ -n $PACMAN_CACHE ]]; then
    sudo pacman -Rns $(pacman -Qtdq) 
  else
    echo "\n🫧 No [pacman] unneeded packages"
  fi 

  if [[ -z PACMAN_CACHE ]]; then
    yay -Rns $(yay -Qtdq)
  else
    echo "🫧 No [yay] unneeded packages\n"
  fi 

  clear-cache

  echo "\n🛀 All clean"
}

function help(){
  curl cheat.sh/$1
}

function kill-port(){
  sudo kill -9 $(sudo lsof -t -i:$1)
}

function aws-session(){
  aws sts get-session-token --serial-number arn:aws:iam::<>:mfa/abel --output json --token-code=$1 | jq -r '.Credentials' > ~/temporal-aws-credentials.json

  if [[ -s ~/temporal-aws-credentials.json ]]; then
    AWS_ACCESS_KEY_ID=$(jq -r '.AccessKeyId' ~/temporal-aws-credentials.json)
    AWS_SECRET_ACCESS_KEY=$(jq -r '.SecretAccessKey' ~/temporal-aws-credentials.json)
    AWS_SESSION_TOKEN=$(jq -r '.SessionToken' ~/temporal-aws-credentials.json)

    export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
    export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
    export AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN

    source ~/.zshrc

    rm ~/temporal-aws-credentials.json

    echo "🔑 AWS session created"
  else
    rm ~/temporal-aws-credentials.json
  fi
}

# export FZF_DEFAULT_COMMAND="nvim"
export FZF_DEFAULT_OPTS='--border --preview "bat {}" '
export PATH="$PATH:$HOME/.config/composer/vendor/bin"

export OPENAI_API_KEY=""

export GOPATH="$HOME/go"
PATH="$GOPATH/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#source /usr/share/nvm/init-nvm.sh
export PATH="$HOME/.symfony5/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Disable warning about zsh prompt
# typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
# neofetch --ascii --source /home/abeldlp/Tools/pikachu3.txt --ascii_colors 3 5 6 2
