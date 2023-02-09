#!/bin/bash
opt=$(hyprctl activewindow)

xway=$(echo "$opt" | awk '/xwayland:/{print $2}')

pid=$(echo "$opt" | awk '/pid:/{print $2}')

if [ $xway == "1" ]; then
	notify-send -u critical "Checkxway" "Running Xwayland\nPID: ${pid}"
else
	notify-send "Checkxway" "Running wayland\nPID: ${pid}"
fi
