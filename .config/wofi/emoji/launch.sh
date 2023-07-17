selected=$(cat ~/.config/wofi/emoji/list | wofi --conf ~/.config/wofi/config)
# if no options selected
if test -z "$selected"; then
    exit
fi
echo "$selected" | cut -d " " -f 1 -s | wl-copy -n
