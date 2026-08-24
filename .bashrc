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
alias ...='cd ../../'
alias grep='grep --color=auto'
alias sizesort='du -d 1 -ah . 2>/dev/null | sort -rh'

alias gtop='LANG=en_US.utf8 TERM=xterm-256color gtop'
alias r='ranger'
alias nf='neofetch'

alias cmatrix='neo-matrix -D --speed=12 --charset=DEVANAGARI'

alias wscan='iwctl station wlan0 scan'
alias wshow='iwctl station wlan0 show'
alias wlist='iwctl station wlan0 get-networks'
alias wdisc='iwctl station wlan0 disconnect'
alias wconn='iwctl station wlan0 connect'

## Path configuration
export BUN_INSTALL="$HOME/.bun"

BUN_PATH="$BUN_INSTALL/bin"
GO_PATH="$HOME/go/bin"
CARGO_PATH="$HOME/.cargo/bin/"

## Flutter config
FVM_PATH="$HOME/.fvm_flutter/bin"
FVM_FLUTTER_PATH="$HOME/fvm/default/bin"
export CHROME_EXECUTABLE="/usr/bin/google-chrome-stable"

## Neovim Mason-installed tools (LSPs, formatters, etc.)
MASON_PATH="$HOME/.local/share/nvim/mason/bin"

export PATH=$PATH:~/.local/bin/:$CARGO_PATH:$BUN_PATH:$GO_PATH:$FVM_PATH:$FVM_FLUTTER_PATH:$MASON_PATH

[ -f ~/.bash_aliases_nav ] && source ~/.bash_aliases_nav

neofetch
if [ "$TERM_PROGRAM" != "vscode" ]; then
  if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ "$TERM" =~ xterm ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
      exec tmux
  fi
fi


eval "$(starship init bash)"

export RIPGREP_CONFIG_PATH="$HOME/.rg"

export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

export PATH="/home/immo/.shorebird/bin:$PATH"
export PATH="$PATH:$HOME/.pub-cache/bin"

eval "$(direnv hook bash)"
