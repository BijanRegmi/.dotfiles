#!/bin/sh

today=$(date +%Y-%m-%d)

nepToday=$(curl -s 'https://www.hamropatro.com/getMethod.php' -X POST --data-raw "actionName=dconverter&datefield=${today}&convert_option=eng_to_nep" | awk -F "<span>|</span>" '{print $2}')

notify-send "Today's Nepali Date:" "${nepToday}"

