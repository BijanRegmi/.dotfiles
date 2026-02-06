#
# ~/.bash_profile
#

# Set default editor
export EDITOR='nvim'
export _JAVA_AWT_WM_NONREPARENTING=1

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start X-Server
# startx

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[ -f /home/immo/.dart-cli-completion/bash-config.bash ] && . /home/immo/.dart-cli-completion/bash-config.bash || true
## [/Completion]
