#!/bin/bash
set -e

rm -rf ~/.cache/wal/*
wal -i ~/.wallpapers/wallpaper.jpg

cd ~/.dotfiles/st
sudo make clean install

# killall dwm
