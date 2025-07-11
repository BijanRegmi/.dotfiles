#!/bin/sh

displays=$(yabai -m query --displays | jq length)

function setup_space {
  local idx="$1"
  local name="$2"

  local space=$(yabai -m query --spaces --space "$idx")

  if [ -z "$space" ]; then
    yabai -m space --create
  fi

  yabai -m space "$idx" --label "$name"
}


setup_space 1 messaging
setup_space 2 web
setup_space 3 code
setup_space 4 web2
setup_space 5 sp5
setup_space 6 sp6

echo $displays
if [ displays == "2" ]; then
  echo "Moving to display 2"
  yabai -m space 2 --display 2
  yabai -m space 3 --display 2
  yabai -m space 4 --display 2
fi
