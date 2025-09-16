# p10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# => ZSH Settings
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"


# Themes
ZSH_THEME="robbyrussell"
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Hyphen-insensetive completion
# HYPHEN_INSENSITIVE="true"

# Update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Update frequency (days)
zstyle ':omz:update' frequency 7

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Show dots when completion is in progress
COMPLETION_WAITING_DOTS="true"

# Mark unstaged files as dirty (make faster experience in large Git projects)
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Time format after command
HIST_STAMPS="dd.mm.yyyy"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# => Manage Plugins
# ==> zplug section
source ~/.zplug/init.zsh

zplug "zplug/zplug", hook-build:"zplug --self-manage"
zplug "zsh-users/zsh-syntax-highlighting", as:plugin, defer:2
zplug "zsh-users/zsh-autosuggestions", as:plugin, defer:2
zplug "Aloxaf/fzf-tab", as:plugin, defer:2
zplug "MichaelAquilina/zsh-you-should-use"
zplug "fdellwing/zsh-bat"
zplug "alexrochas/zsh-extract"


# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# ==> Other
plugins=(
    git
    sudo
    colored-man-pages
    direnv
    fzf
    pj
)
source $ZSH/oh-my-zsh.sh

# => User Settings

# Load local envs and secrets
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Projects dir for pj
export PROJECT_PATHS=(~/Projects)

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# you-should-use tips position
export YSU_MESSAGE_POSITION="after"

# => Aliases 
alias zcfg="nvim ~/.zshrc"
alias vim="nvim"
alias ls="lsd"
alias gpt="proxychains4 sgpt"

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Reload config at change
autoload -Uz add-zsh-hook

ZSHRC="$HOME/.zshrc"
ZSHRC_HASH_FILE="$HOME/.zshrc.sha1"

function check_zshrc_update() {
  if [[ -f "$ZSHRC" ]]; then
    current_hash=$(sha1sum "$ZSHRC" | awk '{print $1}')
    saved_hash=$(<"$ZSHRC_HASH_FILE")

    if [[ "$current_hash" != "$saved_hash" ]]; then
      echo "🔄 .zshrc was changed, reload config..."
      source "$ZSHRC"
      echo "$current_hash" > "$ZSHRC_HASH_FILE"
    fi
  fi
}

add-zsh-hook precmd check_zshrc_update

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
