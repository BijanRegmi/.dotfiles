#!/bin/bash

# Set the wallpaper
hyprpaper &

# Gamma correction for eye protection
gammastep -O 3500 &

# Start waybar
waybar &

#start notification service
dunst &

