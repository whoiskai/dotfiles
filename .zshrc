# Custom: Lazy-load antidote and generate the static load file only when needed
source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
zsh_plugins=${ZDOTDIR:-$HOME}/.zsh_plugins
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  (
    source /path-to-antidote/antidote.zsh
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

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

autoload -U +X bashcompinit && bashcompinit

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
