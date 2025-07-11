#
# ~/.bash_profile
#

# Set default editor
export EDITOR='nvim'
export _JAVA_AWT_WM_NONREPARENTING=1

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

[[ -f ~/.bashrc ]] && . ~/.bashrc
