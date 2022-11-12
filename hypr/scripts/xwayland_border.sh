#!/bin/sh

pidFile=/tmp/xwayland_border.pid

if test -f "$pidFile";then
	# Exit if script is already running
	exit
fi

trap "rm -f $pidFile" EXIT
echo $$ > $pidFile

function handle {
    if [[ ${1:0:12} == "activewindow" ]]; then
        xway=$(hyprctl activewindow | awk '/xwayland:/{print $2}')
        if [ $xway == "1" ]; then
            hyprctl keyword 'general:col.active_border' 0xffff0000
        else
            hyprctl keyword 'general:col.active_border' 0xffbbbbbb
        fi
    fi
}

socat - UNIX-CONNECT:/tmp/hypr/$(echo $HYPRLAND_INSTANCE_SIGNATURE)/.socket2.sock | while read line; do handle $line; done
