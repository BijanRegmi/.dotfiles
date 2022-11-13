#!/bin/bash
xway=$(hyprctl activewindow | awk '/xwayland:/{print $2}')
if [ $xway == "1" ]; then
	notify-send -u critical "Checkxway" "Running Xwayland"
else
	notify-send "Checkxway" "Running wayland"
fi
