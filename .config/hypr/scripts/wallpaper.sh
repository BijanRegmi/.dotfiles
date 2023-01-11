#!/bin/bash

folder=$(cut -d/ -f1 ~/.wallpapers/.current)
curr=$(cut -d/ -f2 ~/.wallpapers/.current)
count=$(ls ~/.wallpapers/$folder | wc -l)

if [[ $1 -eq '1' ]]; then
    curr=$(expr $curr + 1)
else
    curr=$(expr $curr - 1)
fi

if [ $curr -gt $count ]; then
    curr=$(expr $curr - $(expr $count))
elif [ $curr -eq '0' ]; then
    curr=$count
else
    echo "Curr is: ${curr}"
fi

name=~/.wallpapers/$folder/$curr.jpg

cp $name ~/.wallpapers/wallpaper.jpg

if pidof hyprpaper; then
    pkill hyprpaper
fi
hyprpaper > /dev/null 2>&1 &

notify-send "Wallpaper Updated" "$folder: [ $curr / $count ]" -r 69

echo $folder/$curr > ~/.wallpapers/.current
