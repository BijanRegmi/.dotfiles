#####################
#   Laucher Script  #
#####################

DIR="$HOME/.config/polybar"
killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar -q bar-eDP1 -c "$DIR"/config.ini &
polybar -q bar-HDMI -c "$DIR"/config.ini &