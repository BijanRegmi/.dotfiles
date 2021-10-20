shutdown="    Shutdown"
reboot="    Reboot"
sleep="⏾     Sleep"
logout="    Logout"

selected_option=$(echo "$shutdown
$reboot
$sleep
$logout" | rofi -dmenu\
                  -l 4\
                  -p "⏻")

if [ "$selected_option" == "$logout" ]
then
    killall -u immo
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