#
# ~/.bash_profile
#

# Set default editor
export EDITOR='nvim'
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export _JAVA_AWT_WM_NONREPARENTING=1

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

[[ -f ~/.bashrc ]] && . ~/.bashrc
