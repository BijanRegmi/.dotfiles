#!/bin/bash

list=$(iwctl station wlan0 get-networks \
	| tail -n +5 \
	| sed -e "s/.\[0m  //g; s/.\[1;90m> //g; s/^[[:space:]]*//" \
	| awk '{for (i=NF-2; i>0; i--) printf $i" ";print ""}'
)

selected="$(echo -e "Scan\nDisconnect\nInfo\nRefresh ip\n$list" | wofi --conf ~/.config/wofi/wifimenu/config)"

# if no options selected
if test -z "$selected"; then
    exit
fi

show_info (){
	res=$(iwctl station wlan0 show)
	state=$(echo -e "$res" | awk '/State/ {print $2}')
	connectedTo=$(echo -e "$res" | awk '/Connected network/ {for (i=3; i<=NR;i++) printf $i" "}')
	addr=$(echo -e "$res" | awk '/IPv4 address/ {print $3}')
	notify-send "State: $state" "Name: $connectedTo\nIP: $addr"
}

case $selected in
	"Scan")
		iwctl station wlan0 scan
		;;
	"Disconnect")
		iwctl station wlan0 disconnect
		notify-send "Disconnected wifi."
		;;
	"Info")
		show_info
		;;
	"Refresh ip")
		echo $(~/.config/wofi/gsudo/launch.sh) | sudo -S resolvconf -u
		;;
	*)
		iwctl station wlan0 connect $selected
		;;
esac
