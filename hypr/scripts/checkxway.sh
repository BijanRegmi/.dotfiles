#!/bin/bash
xway=$(hyprctl activewindow | awk '/xwayland:/{print $2}')
if [ $xway == "1" ]; then
    hyprctl keyword 'general:col.active_border' 0xffff0000
else
    hyprctl keyword 'general:col.active_border' 0xffbbbbbb
fi
