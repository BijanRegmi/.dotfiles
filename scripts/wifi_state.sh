state=$(iwctl station wlan0 show | grep State | awk '{ print $2 }')
if [ $state == "connected" ]; then
	echo "%{A1:st -e bash -c 'iwctl station wlan0 show; read;':}%{F#00ff00}%{F-}%{A}"
else
    echo "%{A1:st -e bash -c 'iwctl station wlan0 scan; sleep 1; iwctl station wlan0 get-networks; read a; iwctl station wlan0 connect $a; bash;':}%{F#ff0000}%{F-}%{A}"
fi