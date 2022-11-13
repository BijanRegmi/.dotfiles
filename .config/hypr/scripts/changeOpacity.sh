#!/bin/bash

current_option=$(hyprctl getoption 'decoration:active_opacity' | awk '/float/{printf("%.2f", $2)}')

if [ "$1" = "--inc" ]; then
    newval=$(echo "$current_option + 0.05" | bc)
elif [ "$1" = "--dec" ]; then
    newval=$(echo "$current_option - 0.05" | bc)
elif [ "$1" = "--res" ]; then
	newval="1"
else
	exit
fi

if [[ $(echo "if (${newval} >= 0 && ${newval} <= 1) 1 else 0" | bc) -eq 1 ]]; then
    hyprctl keyword 'decoration:active_opacity' "${newval}"
fi
