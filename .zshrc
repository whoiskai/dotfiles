# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Custom: Lazy-load antidote and generate the static load file only when needed
source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
zsh_plugins=${ZDOTDIR:-$HOME}/.zsh_plugins
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  (
    # source /path-to-antidote/antidote.zsh
    antidote bundle <${zsh_plugins}.txt >${zsh_plugins}.zsh
  )
fi
source ${zsh_plugins}.zsh

# My aliases
source $HOME/.aliases

autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# Custom: right prompt timestamp
# RPROMPT="%F{250}%K{000} %D{%H:%M:%S}"

# Custom: fix gpg
export GPG_TTY=$(tty)

# Custom: autojump plugin
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# Custom: bash completion
[ -r "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" ] && . "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"

# Custom: scmpuff
_evalcache scmpuff init -s

# smart completion check for left and right
zstyle ':completion:*' matcher-list 'l:|=* r:|=*' 

# cd without typing cd
setopt  autocd autopushd

timezsh() {
    shell=${1-$SHELL}
    for i in $(seq 1 10); do time $shell -i -c exit; done
}

# Opt out of homebrew analytics
# https://docs.brew.sh/Analytics
export HOMEBREW_NO_ANALYTICS=1

export EDITOR='nano'
export VISUAL='nano'

# Terraform cache
export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
export TG_LOG_FORMAT=bare
export TG_PROVIDER_CACHE=1
export TG_PROVIDER_CACHE_DIR="$HOME/.terraform.d/plugin-cache"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

autoload -U +X bashcompinit && bashcompinit

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

alias cd="z"
eval "$(zoxide init zsh)"

# mise Configuration
eval "$(mise activate zsh)"

# Node.js Cloudflare CA certificates
export NODE_EXTRA_CA_CERTS="/Users/whoiskai/.config/cloudflare/Cloudflare_CA.pem"
