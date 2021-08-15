lock="    Lock"
logout="    Logout"
shutdown="    Shutdown"
reboot="    Reboot"
sleep="    Sleep"

selected_option=$(echo "$lock
$logout
$sleep
$reboot
$shutdown" | rofi -dmenu\
                  -i\
                  -p "ﮣ"\
                  -config "~/.config/rofi/themes/powermenu.rasi" )

if [ "$selected_option" == "$lock" ]
then
    echo "Sed i dont have lock feature yet :("
elif [ "$selected_option" == "$logout" ]
then
    killall dwm
elif [ "$selected_option" == "$shutdown" ]
then
    systemctl poweroff
elif [ "$selected_option" == "$reboot" ]
then
    systemctl reboot
elif [ "$selected_option" == "$sleep" ]
then
    systemctl suspend
else
    echo "No match"
    
fi