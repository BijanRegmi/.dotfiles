state=$(iwctl station wlan0 show | grep State | awk '{ print $2 }')
if [ $state == "connected" ]; then
	echo "%{F#00ff00}%{F-}"
else
    echo "%{F#ff0000}%{F-}"
fi