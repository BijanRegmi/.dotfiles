#!/bin/bash
shutdown="<span size='0.001pt'>Shutdown</span>⏼"
reboot="<span size='0.001pt'>Reboot</span>"
sleep="<span size='0.001pt'>Sleep</span>⏾"
logout="<span size='0.001pt'>Logout</span>"
lock="<span size='0.001pt'>Lock</span>"

actions="$shutdown\n$reboot\n$sleep\n$logout\n$lock"

selected="$(echo -e "$actions"| wofi --conf ~/.config/wofi/powermenu/config)"

# if no options selected
if test -z "$selected"; then
    exit
fi

case $selected in
        $shutdown)
			systemctl poweroff
			;;
        $reboot)
			systemctl reboot
			;;
		$sleep)
			systemctl suspend
			;;
        $logout)
			killall -u immo
            ;;
		$lock)
			swaylock
			;;
		*)
			;;
esac
