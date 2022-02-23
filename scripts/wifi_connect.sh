#!/bin/bash
op=$(iwctl station wlan0 show)
state=$(echo "${op}" | grep State | awk '{print $2}')

if [ "${state}" == "connected" ]; then
    ssid=$(echo "${op}" | grep "Connected network" | awk '{print $3}')
    echo "Wifi is already connected to ${ssid}"
elif [ "${state}" == "connecting" ]; then
    echo -e "Please wait wifi is trying to connect.\nIf you wish to stop connecting run 'iwctl station wlan0 disconnect'"
else
    echo "[+] Scanning wifi"
    iwctl station wlan0 scan

    echo "[+] Network List"
    iwctl station wlan0 get-networks

    read -p "[*] Enter SSID to connect: " ssid
    echo "[+] Attempting to connect to ${ssid}"
    iwctl station wlan0 connect ${ssid}
fi

echo -e "\n\nPress enter to exit!"
read