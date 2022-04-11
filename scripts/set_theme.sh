#!/bin/bash
set -e

rm -rf ~/.cache/wal/*
wal -q -i ~/.wallpapers/wallpaper.jpg

echo -e "Setting New theme!"

cd ~/.dotfiles/st
sudo make clean install > /dev/null

# killall dwm
