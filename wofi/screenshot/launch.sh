#!/bin/bash
copy_full="FullScreen Copy"
save_full="FullScreen Save"
copy_sel="Selection Copy"
save_sel="Selection Save"
delay_copy_full="FullScreen Delay Copy"
delay_save_full="FullScreen Delay Save"
delay_copy_sel="Selection Delay Copy"
delay_save_sel="Selection Delay Save"

actions="$copy_full\n$copy_sel\n$save_full\n$save_sel\n$delay_copy_full\n$delay_copy_sel\n$delay_save_full\n$delay_save_sel"

selected="$(echo -e "$actions"| wofi --conf ~/.config/wofi/screenshot/config --sort-order alphabetical)"

# if no options selected
if test -z "$selected"; then
    exit
fi

case $selected in
        $copy_sel)
			grim -g "$(slurp)" - | wl-copy
			notify-send "Screenshot" "Selction copied to clipboard"
			;;
        $copy_full)
			grim - | wl-copy
			notify-send "Screenshot" "Fullscreen copied to clipboard"
			;;
		$save_sel)
			name=/home/$USER/Pictures/screenshot_$(date +%b-%d_%H-%H-%M-%S).png
			grim -g "$(slurp)" "$name"
			notify-send "Screenshot" "Selection saved to $name"
			;;
        $save_full)
			name=/home/$USER/Pictures/screenshot_$(date +%b-%d_%H-%H-%M-%S).png
			grim "$name"
			notify-send "Screenshot" "Fullscreen saved to $name"
            ;;
        $delay_copy_sel)
			sleep 3 && grim -g "$(slurp)" - | wl-copy
			notify-send "Screenshot" "Selction copied to clipboard"
			;;
        $delay_copy_full)
			sleep 3 && grim - | wl-copy
			notify-send "Screenshot" "Fullscreen copied to clipboard"
			;;
		$delay_save_sel)
			sleep 3
			name=/home/$USER/Pictures/screenshot_$(date +%b-%d_%H-%H-%M-%S).png
			grim -g "$(slurp)" "$name"
			notify-send "Screenshot" "Selection saved to $name"
			;;
        $delay_save_full)
			sleep 3 
			name=/home/$USER/Pictures/screenshot_$(date +%b-%d_%H-%H-%M-%S).png
			grim "$name"
			notify-send "Screenshot" "Fullscreen saved to $name"
            ;;
esac
