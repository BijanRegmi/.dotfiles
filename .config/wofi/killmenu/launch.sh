#!/bin/bash
ps=$(ps -ux --sort -pid)

selected=$(echo "$ps" | tail -n +2 | awk '{for (i=11; i<NF; i++) printf $i " "; if (NF >= 11) print $NF; }' | wofi --conf ~/.config/wofi/killmenu/config)

# if no options selected
if test -z "$selected"; then
    exit
fi

kill -9 $(echo "$ps" | grep "$selected" | awk '{print $2}')
