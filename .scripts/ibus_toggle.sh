#!/bin/bash
engine=$(ibus engine)

ENGLISH="xkb:us::eng"
VIETNAM="Bamboo"
if [[ "$engine" == "$ENGLISH" ]]; then
    ibus engine $VIETNAM
    polybar-msg hook ibus 1 &>/dev/null || true
    dunstify -h string:x-dunst-stack-tag:ibus -A 'ibus,default' -a "IBUS" -i "~/.scripts/img/vn.svg" "VI"
else
    ibus engine $ENGLISH
    polybar-msg hook ibus 1 &>/dev/null || true
    dunstify -h string:x-dunst-stack-tag:ibus -A 'ibus,default' -a "IBUS" -i "~/.scripts/img/us.svg" "US"
fi
