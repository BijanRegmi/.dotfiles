state=$(iwctl station wlan0 show | grep State | awk '{ print $2 }')
if [ $state == "connected" ]; then
	echo "%{A1:st -e '/home/${USER}/.dotfiles/scripts/wifi_connect.sh':}%{F#00ff00}%{F-}%{A}"
elif [ $state == "connecting" ]; then
    echo "%{A1:st -e '/home/${USER}/.dotfiles/scripts/wifi_connect.sh':}%{F#00ffff}%{F-}%{A}"
else
    echo "%{A1:st -e '/home/${USER}/.dotfiles/scripts/wifi_connect.sh':}%{F#ff0000}%{F-}%{A}"
fi