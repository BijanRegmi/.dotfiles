prev=$(cat /tmp/rx)
curr=$(cat /sys/class/net/wlan0/statistics/rx_bytes)
kilo=$(echo "($curr - $prev)/1024" | bc)

echo $curr > /tmp/rx

if [ $kilo  -gt 1024 ]; then
	echo "$(echo "scale = 1; $kilo / 1024" | bc) MB/s"
else
	echo "$kilo KB/s"
fi