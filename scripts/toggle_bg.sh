arch="/home/$USER/.wallpapers/arch.jpg"
itachi="/home/$USER/.wallpapers/itachi.jpg"
wall="/home/$USER/.wallpapers/wallpaper.jpg"

if cmp -s $arch $wall; then
    cp $itachi $wall
else
    cp $arch $wall
fi

nitrogen --restore