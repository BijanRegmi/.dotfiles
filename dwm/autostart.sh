# Start KeyBindings
xbindkeys &

# Set Background
nitrogen --restore &

# Redshift for those precious eyes
redshift -O 3500 &

# Start Network-Manager-Applet
# nm-applet &

# Turn on numlock
numlockx on &

# Setup Window Compositor
picom --config ~/.config/picom/picom.conf &

# Start notification-daemon
dunst &

# Xmodmap
xmodmap ~/.xmodmap &

# Start mpd daemon
[ ! -s ~/.config/mpd/pid ] && mpd
