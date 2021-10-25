output=$(lsblk)

all=$(echo "$output" | awk '{if(length($7)>0) $9="Mounted"; else $9="Not Mounted"} /^[├,└]/ {print "[ " substr($1,3) "\t" $4 "\t" $9 " ]"}')

selected_option=$(echo "$all" | rofi -dmenu)

name=$(echo $selected_option | awk '{print $2}')
mounted=$(echo "$selected_option" | awk '{print $4}')

if [ $mounted == "Not" ]
then
    code="mkdir /media/"$name" & sudo mount /dev/"$name" /media/"$name
    echo $code
    eval "$code"
fi

