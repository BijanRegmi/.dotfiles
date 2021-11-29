#####################
#   Laucher Script  #
#####################

DIR="$HOME/.config/polybar"
killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

for i in /sys/class/hwmon/hwmon*/temp*_input; do if [ "$(cat ${i%_*}_label 2>/dev/null)" = "Core 0" ]; then echo $(readlink -f $i) > $DIR/temp_location.ini; fi done

polybar -q bar-eDP1 -c "$DIR"/config.ini &
# polybar -q bar-HDMI -c "$DIR"/config.ini &