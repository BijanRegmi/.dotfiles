password="$(echo "" | wofi --conf ~/.config/wofi/gsudo/config)"

# if no options selected
if test -z "$password"; then
    exit
fi

echo $password
