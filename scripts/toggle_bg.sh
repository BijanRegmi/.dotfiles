set -e

count=$(expr $(ls -a ~/.wallpapers | wc -l) - 4)
curr=$(cat ~/.wallpapers/.wallpaper)
if [[ $1 -eq '1' ]]; then
    curr=$(expr $curr + 1)
else
    curr=$(expr $curr - 1)
fi

if [ $curr -gt $count ]; then
    curr=$(expr $curr - $(expr $count))
fi

name=~/.wallpapers/$curr.jpg

cp $name ~/.wallpapers/wallpaper.jpg
nitrogen --restore

echo $curr > ~/.wallpapers/.wallpaper