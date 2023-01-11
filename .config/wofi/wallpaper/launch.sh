#!/bin/bash

set -e

folders=$(ls -d ~/.wallpapers/*/ | tr '\n' '\0' | xargs -0 -n 1 basename)

folder="$(echo -e "$folders" | wofi --conf ~/.config/wofi/wallpaper/config)"

# if no options selected
if test -z "$folder"; then
    exit
fi

cp ~/.wallpapers/$folder/1.jpg ~/.wallpapers/wallpaper.jpg

if pidof hyprpaper; then
    pkill hyprpaper
fi
hyprpaper&

notify-send "Wallpaper Category Updated" "Choosing wallpapers from ~/.wallpapers/$folder"

echo "$folder/1" > ~/.wallpapers/.current

