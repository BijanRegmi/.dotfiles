#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

reset="\[\033[0m\]"           # Reset Color
Red="\[\033[1;31m\]"          # Bold Red
Cyan="\[\033[1;36m\]"         # Bold Cyan
White="\[\033[0;37m\]"        # White

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

neofetch


