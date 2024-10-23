#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
alias araara=sudo

alias ls='ls -l --color=auto'
alias ll='ls -la'				# List Hidden Files too
alias cp='cp -v'                # Verbose copy
alias cdd='cd ~/.dotfiles/'
alias ..='cd ..'
alias grep='grep --color=auto'

alias gtop='LANG=en_US.utf8 TERM=xterm-256color gtop'
alias r='ranger'
alias nf='neofetch'

alias cmatrix='neo-matrix -D --speed=12 --charset=DEVANAGARI'

alias wscan='iwctl station wlan0 scan'
alias wshow='iwctl station wlan0 show'
alias wlist='iwctl station wlan0 get-networks'
alias wdisc='iwctl station wlan0 disconnect'
alias wconn='iwctl station wlan0 connect'

export ANDROID_HOME='/home/immo/Android/Sdk'
export BUN_INSTALL="$HOME/.bun"

export PATH=$PATH:~/.local/bin/:~/.cargo/bin/:/opt/flutter/bin:$ANDROID_HOME/platform-tools/:$ANDROID_HOME/emulator:$ANDROID_HOME/tools/:$ANDROID_HOME/tools/bin/:$BUN_INSTALL/bin:~/go/bin

cdc() {
    cd $HOME/Documents/Coding/$1
}

_cdc_complete() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local C_DIR=$HOME/Documents/Coding/
    COMPREPLY=( $(compgen -d -S / -- $C_DIR"$cur" | sed -e 's|'$C_DIR'||') )
}

complete -o nospace -F _cdc_complete cdc

neofetch
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ "$TERM" =~ xterm ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    exec tmux
fi


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(starship init bash)"

export RIPGREP_CONFIG_PATH='/home/immo/.rg'
