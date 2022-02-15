#!/bin/bash

pid=$(ps -ef | awk '/[p]icom --config/{print $2}') # [] is to avoid getting the pid of current script

if [[ ${pid} ]]; then
    kill -9 ${pid}
else
    picom --config ~/.config/picom/picom.conf &
fi