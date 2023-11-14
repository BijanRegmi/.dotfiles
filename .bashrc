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

alias gtop='LANG=en_US.utf8 TERM=xterm-256color gtop'
alias r='ranger'
alias nf='neofetch'

alias cmatrix='neo --color=green2 --shortpct=100 --speed=12 --async -d 1.5 --lingerms=1,1 --rippct=0 --maxdpc=1 --charset=DEVANAGARI'

alias wscan='iwctl station wlan0 scan'
alias wshow='iwctl station wlan0 show'
alias wlist='iwctl station wlan0 get-networks'
alias wdisc='iwctl station wlan0 disconnect'
alias wconn='iwctl station wlan0 connect'

reset="\[\033[0m\]"           	# Reset Color
Red="\[\033[1;31m\]"          	# Bold Red
Cyan="\[\033[1;36m\]"         	# Bold Cyan
White="\[\033[0;37m\]"        	# White

# If logged in with root main color will be red
if [[ ${EUID} == 0 ]] ; then
  main_col=$Red
else
  main_col=$Cyan
fi

function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		echo "[${BRANCH}]"
	else
		echo ""
	fi
}

front_arrow="\n$main_col\342\224\214\342\224\200["
bridge="$main_col]\342\224\200["
bottom_arrow="$main_col\342\224\224\342\224\200\342\224\200>"
export PS1="${front_arrow}$White\t${bridge}$White\u${bridge}$White\w$main_col]\n${bottom_arrow}$Red\$("parse_git_branch") $main_col\$ $reset"

# Color scheme for ls
LS_COLORS='rs=0:di=01;36:ln=01;37:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS

export ANDROID_HOME='~/Android/Sdk'
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
