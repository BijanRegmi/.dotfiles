#!/bin/bash

if [ -z "$1" ]; then
    exit
fi

current_option=$(hyprctl getoption "$1" | awk '/int/{print $2}')

if [ "$current_option" = '1' ]; then
    hyprctl keyword "$1" 0
else
    hyprctl keyword "$1" 1
fi
